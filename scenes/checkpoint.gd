extends Area2D

@export var first_position: Vector2
@export var second_position: Vector2
@export var clock1: Node2D
@export var clock2: Node2D
@export var ribbon: Polygon2D
@export var fade_timer: Timer
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

func _on_body_entered(body: Node2D) -> void:
	if body.has("is_player") and is_checkpoint_collected == false:
		is_checkpoint_collected = true
		clock1.fade()
		clock2.fade()
		ribbon.fade()
		fade_timer.start()

func _on_fade_timer_timeout() -> void:
	queue_free()
