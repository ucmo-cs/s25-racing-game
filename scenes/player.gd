extends CharacterBody2D

var wheel_base = 70  # Distance from front to rear wheel
var steering_angle = 45  # Amount that front wheel turns, in degrees
var steer_direction
var engine_power = 400  # Forward acceleration force.
var friction = -55
var drag = -0.06
var braking = -450
var max_speed_reverse = 250
var slip_speed = 400  # Speed where traction is reduced
var traction_fast = 2.5 # High-speed traction
var traction_slow = 10  # Low-speed traction

func _physics_process(delta: float) -> void:
	#Acceleration
	var acceleration = Vector2.ZERO
	
	#Get Input
	var turn = Input.get_axis("Left", "Right")
	steer_direction = turn * deg_to_rad(steering_angle)
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
