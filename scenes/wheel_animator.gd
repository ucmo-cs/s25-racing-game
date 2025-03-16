extends AnimationPlayer

func _on_player_player_speed(speed: float, direction: float) -> void:
	if speed > 0:
		if current_animation == "idle" or "[stop]":
			play("driving")
			if direction > 0:
				speed_scale = 1 * (snappedf(speed, 1) / 100)
			elif direction < 0:
				speed_scale = -1
	else:
		if current_animation == "driving":
			play("idle")
