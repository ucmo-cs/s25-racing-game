extends Label

func _on_player_player_speed(speed: float, d: float) -> void:
	text = "Speed: " + str(speed/2.5).pad_decimals(0)
