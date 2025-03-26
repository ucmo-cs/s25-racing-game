extends Node2D
@export var clockspin_animationplayer: AnimationPlayer
@export var clockfloat_animationplayer: AnimationPlayer
@export var clockfade_animationplayer: AnimationPlayer

func _ready() -> void:
	clockspin_animationplayer.play("spin")
	clockfloat_animationplayer.play("float")

func set_time(seconds: int) -> void:
	clockspin_animationplayer.seek(seconds)
	
func fade() -> void:
	clockfloat_animationplayer.pause()
	clockspin_animationplayer.pause()
	clockfade_animationplayer.play("fade")

func _on_clock_fade_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
