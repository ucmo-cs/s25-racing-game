extends Sprite2D

signal player_entered

func _on_area_2d_body_entered(body: Node2D) -> void:
	player_entered.emit()
