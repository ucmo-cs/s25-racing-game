extends Control

@export var points_label: Label

signal main_menu_button_pressed()
signal try_again_button_pressed()

func _on_points_earned(points: int):
	points_label.text = "Points: " + str(points)

func _on_main_menu_button_pressed() -> void:
	main_menu_button_pressed.emit()

func _on_try_again_button_pressed() -> void:
	try_again_button_pressed.emit()
