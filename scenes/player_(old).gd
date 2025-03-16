extends CharacterBody2D

@export var wheel_base: float #How far apart the wheels are
@export var car_acceleration: float
@export var car_deceleration: float
@export var car_max_speed: float
@export var max_steer_angle: float
@export var steer_angle_change_speed: float

#var _car_heading: float
var _car_speed: float
var _steer_angle: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_car_speed = 0
	_steer_angle = 0
	#_car_heading = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Get Input
	if Input.is_action_pressed("Gas"):
		_car_speed = min(_car_speed + car_acceleration, car_max_speed)
	else:
		_car_speed = min(0, _car_speed - car_deceleration)
	if Input.is_action_pressed("Left"):
		_steer_angle = max(_steer_angle - steer_angle_change_speed, -1 * max_steer_angle)
	if Input.is_action_pressed("Right"):
		_steer_angle = min(_steer_angle + steer_angle_change_speed, max_steer_angle)
	
	#---- Old Steering Code
	#Calculate Wheel Locations
	#var _car_heading_direction: Vector2 = Vector2(cos(_car_heading), sin(_car_heading))
	#var _front_wheel_location: Vector2 = self.position + wheel_base/2 * _car_heading_direction
	#var _back_wheel_location: Vector2 = self.position - wheel_base/2 * _car_heading_direction
	#
	#Move Wheels in Direction
	#_back_wheel_location += _car_speed * Vector2(cos(_car_heading) , sin(_car_heading));
	#_front_wheel_location += _car_speed * Vector2(cos(_car_heading + _steer_angle) , sin(_car_heading + _steer_angle))
	#
	#Calculate new center of car and new car heading
	#self.position = (_front_wheel_location + _back_wheel_location) / 2;
	#_car_heading = atan2( _front_wheel_location.y - _back_wheel_location.y , _front_wheel_location.x - _back_wheel_location.x );
