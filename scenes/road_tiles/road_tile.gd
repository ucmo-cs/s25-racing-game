class_name RoadTile
extends Node2D

enum Direction {UP, DOWN, LEFT, RIGHT, NONE}
@export var entrance: RoadTile.Direction
@export var exit: RoadTile.Direction
@export var barrier: TileMapLayer
signal checkpoint_collected()

func _ready() -> void:
	barrier.enabled = false

func create_barrier() -> void:
	barrier.enabled = true

func _on_checkpoint_checkpoint_collected() -> void:
	checkpoint_collected.emit()
