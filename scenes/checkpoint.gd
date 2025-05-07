extends Area2D

@export var clock1: Node2D
@export var clock2: Node2D
@export var ribbon: Polygon2D
@export var fade_timer: Timer
var is_checkpoint_collected: bool
signal checkpoint_collected()

func _ready() -> void:
	is_checkpoint_collected = false

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("is_player") and is_checkpoint_collected == false:
		is_checkpoint_collected = true
		clock1.fade()
		clock2.fade()
		ribbon.fade()
		fade_timer.start()
		checkpoint_collected.emit()

func _on_fade_timer_timeout() -> void:
	queue_free()
