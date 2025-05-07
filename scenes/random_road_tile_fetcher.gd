extends Node

@export var start_tile: PackedScene
@export var up_entrance_tiles: Array[PackedScene]
@export var left_entrance_tiles: Array[PackedScene]
@export var right_entrance_tiles: Array[PackedScene]

func random_up_entrance_tile() -> PackedScene:
	return up_entrance_tiles[randi() % up_entrance_tiles.size()]

func random_left_entrance_tile() -> PackedScene:
	return left_entrance_tiles[randi() % left_entrance_tiles.size()]

func random_right_entrance_tile() -> PackedScene:
	return right_entrance_tiles[randi() % right_entrance_tiles.size()]
