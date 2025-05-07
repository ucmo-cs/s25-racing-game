extends Label

@export var initial_time_remaining: int
var time_remaining: int
var can_countdown: bool
signal out_of_time()

func _ready() -> void:
	time_remaining = initial_time_remaining
	can_countdown = true

func _on_one_second_timer_timeout() -> void:
	if can_countdown:
		time_remaining -= 1
		text = "Time Remaining: " + str(time_remaining)
		if time_remaining <= 0:
			can_countdown = false
			text = "Time Remaining: " + str(0)
			out_of_time.emit()


func _on_game_ui_checkpoint_collected() -> void:
	time_remaining += 5
