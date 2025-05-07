extends Node2D

@export var checkpoint_scene: PackedScene
	
func create_checkpoint(new_position: Vector2, new_rotation: float) -> void:
	var new_checkpoint_instance = checkpoint_scene.instantiate()
	add_child(new_checkpoint_instance)
	new_checkpoint_instance.create_checkpoint(new_position, new_rotation) 
