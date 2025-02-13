extends Sprite2D

var x_step: int
var y_step: int

func _ready() -> void:
	x_step = texture.get_width() / 2
	y_step = texture.get_height() / 2

signal player_entered

func _on_area_2d_body_entered(body: Node2D) -> void:
	player_entered.emit()
