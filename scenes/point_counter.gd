extends Node

@export var one_second_timer: Timer
var current_points: int
var can_keep_counting: bool
signal points_earned(points: int)

func _ready() -> void:
	current_points = 0
	can_keep_counting = true

func _on_game_over() -> void:
	points_earned.emit(current_points)

func _on_one_second_timer_timeout() -> void:
	current_points += 1
