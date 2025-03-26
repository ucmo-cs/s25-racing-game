extends Node

@export var checkpoint_manager: Node2D
@export var marker1: Marker2D
@export var marker2: Marker2D

func _ready() -> void:
	checkpoint_manager.create_checkpoint(marker1.position, marker2.position)
