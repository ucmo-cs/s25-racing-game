extends Label

func _on_game_ui_player_speed(speed: float) -> void:
	text = "Speed: " + str(speed/2.5).pad_decimals(0)
