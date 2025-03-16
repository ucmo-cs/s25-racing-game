extends CharacterBody2D

var wheel_base = 70  # Distance from front to rear wheel
var steering_angle_fast = 55  # Amount that front wheel turns, in degrees
var steering_angle_slow = 80
var steer_direction
var engine_power = 300  # Forward acceleration force.
var friction = -55
var drag = -0.06
var braking = -450
var max_speed_reverse = 250
var slip_speed = 150  # Speed where traction is reduced
var traction_fast = 3 # High-speed traction
var traction_slow = 7  # Low-speed traction
signal player_speed(speed: float, direction: float)

func _physics_process(delta: float) -> void:
	#Acceleration
	var acceleration = Vector2.ZERO
	
	#Get Input
	var turn = Input.get_axis("Left", "Right")
	if velocity.length() > slip_speed:
		steer_direction = turn * deg_to_rad(steering_angle_fast)
	else:
		steer_direction = turn * deg_to_rad(steering_angle_slow)
	
	if Input.is_action_pressed("Gas"):
		acceleration = transform.x * engine_power
	if Input.is_action_pressed("Brake"):
		acceleration = transform.x * braking
	
	#Apply Friction
	if acceleration == Vector2.ZERO and velocity.length() < 50:
		velocity = Vector2.ZERO	
	var friction_force = velocity * friction * delta
	var drag_force = velocity * velocity.length() * drag * delta
	acceleration += drag_force + friction_force
	
	#Calculate steering
	# 1. Find the wheel positions
	var rear_wheel = position - transform.x * wheel_base / 2.0
	var front_wheel = position + transform.x * wheel_base / 2.0
	# 2. Move the wheels forward
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	# 3. Find the new direction vector
	var new_heading = rear_wheel.direction_to(front_wheel)
	#Traction
	var traction = traction_slow
	if velocity.length() > slip_speed:
		traction = traction_fast
	# 4. Set the velocity and rotation to the new direction
	var d = new_heading.dot(velocity.normalized())
	if d > 0: #Forwards
		velocity = lerp(velocity, new_heading * velocity.length(), traction * delta)
	elif d < 0: #Backwards
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	rotation = new_heading.angle()
	
	#Calculate Velocity & move_and_slide()
	velocity += acceleration * delta
	move_and_slide()
	
	#Send out a signal saying what the car's current speed is
	player_speed.emit(velocity.length(), d)
