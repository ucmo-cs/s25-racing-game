extends CharacterBody2D

@export var max_speed: float
@export var acceleration_speed: float
@export var deceleration_speed: float
@export var steer_speed: float
@export var max_steer_angle: float
@export var wheel_base: float

var front_wheel: Node2D
var back_wheel: Node2D
var current_turn_angle: float

func _ready() -> void:
	front_wheel = %FrontWheelLocation
	back_wheel = %BackWheelLocation
	front_wheel.rotation_degrees = 0
	back_wheel.rotation_degrees = 0
	current_turn_angle = 0


func _physics_process(delta: float) -> void:
	#Calculate Speed
	var current_speed: float = velocity.length()
	if Input.is_action_pressed("Gas"):
		current_speed = min(current_speed + acceleration_speed, max_speed)
	else:
		current_speed = max(current_speed - deceleration_speed, 0)
	velocity = velocity.normalized() * current_speed
	#Calculate Steering
	var turn_angle: float
	if Input.is_action_pressed("Left"):
		turn_angle = deg_to_rad(max(-1 * max_steer_angle, current_turn_angle - steer_speed))
	if Input.is_action_pressed("Right"):
		turn_angle = deg_to_rad(min(max_steer_angle, current_turn_angle + steer_speed))
	
	#Calculate Current Wheel Positions
	# 𝑥2 = 𝑥1 + length * cos⁡(𝜃)
	# y2 = y2 + length * sin(𝜃)
	front_wheel.position.x = position.x + (wheel_base / 2) * cos(rotation)
	front_wheel.position.y = position.y + (wheel_base / 2) * sin(rotation)
	back_wheel.position.x = position.x + (wheel_base / 2) * cos(rotation + deg_to_rad(180))
	back_wheel.position.y = position.y + (wheel_base / 2) * sin(rotation + deg_to_rad(180))
	#Calculate Wheel Rotations
	front_wheel.rotation = rotation + turn_angle
	back_wheel.rotation = rotation
	#Calculate New Wheel Positions
	front_wheel.position.x = front_wheel.position.x + current_speed * cos(front_wheel.rotation)
	front_wheel.position.y = front_wheel.position.y + current_speed * sin(front_wheel.rotation)
	#Calculate New Car Rotation
	rotation = (front_wheel.rotation + back_wheel.rotation) / 2
	#Calculate New Car Position
	position.x = (front_wheel.position.x + back_wheel.position.x) / 2
	position.y = (front_wheel.position.y + back_wheel.position.y) / 2
	
	move_and_slide()
