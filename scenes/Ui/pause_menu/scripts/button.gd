extends Button

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"


func _ready():
	# Use Callable to connect signals
	connect("focus_entered", Callable(self, "_on_focus_entered"))
	connect("focus_exited", Callable(self, "_on_focus_exited"))
	$TextureRect.visible = false

func _on_focus_entered():
	$TextureRect.visible = true
	if animation_player:
		animation_player.play("focus")
	else:
		return

func _on_focus_exited():
	$TextureRect.visible = false
