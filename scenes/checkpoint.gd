extends Area2D

@export var first_position: Vector2
@export var second_position: Vector2
@export var clock1: Node2D
@export var clock2: Node2D
@export var ribbon: Polygon2D
@export var fade_timer: Timer
@export var collision_shape: CollisionShape2D
var is_checkpoint_collected: bool
signal checkpoint_collected()

func _ready() -> void:
	is_checkpoint_collected = false

func create_checkpoint(position1: Vector2, position2: Vector2) -> void:
	first_position = position1
	second_position = position2
	clock1.position = first_position
	clock2.position = second_position
	ribbon.set_ribbon_position(first_position, second_position)
	
	#Place the CollisionShape
	collision_shape.position = (first_position + second_position) / 2
	var checkpoint_direction: Vector2 = first_position - second_position
	collision_shape.rotation = atan2(checkpoint_direction.y, checkpoint_direction.x)
	collision_shape.scale.x = first_position.distance_to(second_position) / 2

func _on_body_entered(body: Node2D) -> void:
	if body.has("is_player") and is_checkpoint_collected == false:
		is_checkpoint_collected = true
		clock1.fade()
		clock2.fade()
		ribbon.fade()
		fade_timer.start()

func _on_fade_timer_timeout() -> void:
	queue_free()
