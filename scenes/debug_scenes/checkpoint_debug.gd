extends Node2D

@export var checkpoint_manager: Node2D

func _ready() -> void:
	checkpoint_manager.create_checkpoint(Vector2(-100, 20), Vector2(100, 20))
