extends CanvasLayer


@onready var animation: AnimationPlayer = $Control/AnimationPlayer


func loading () -> bool:
	animation.play("load_start")
	await animation.animation_finished
	return true

func default () -> bool:
	animation.play("default")
	await animation.animation_finished
	return true
