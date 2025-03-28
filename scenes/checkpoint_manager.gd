extends Node2D

@export var checkpoint_scene: PackedScene

func _ready() -> void:
	for i in get_children():
		i.queue_free()
	
func create_checkpoint(position1: Vector2, position2: Vector2) -> void:
	var new_checkpoint_instance = checkpoint_scene.instantiate()
	add_child(new_checkpoint_instance)
	new_checkpoint_instance.create_checkpoint(position1, position2) 
