extends Control

signal player_speed(speed: float)
signal out_of_time()
signal checkpoint_collected()

func _on_global_player_speed(speed: float) -> void:
	player_speed.emit(speed)

func _on_global_checkpoint_collected() -> void:
	checkpoint_collected.emit()

func _on_time_out_of_time() -> void:
	out_of_time.emit()
