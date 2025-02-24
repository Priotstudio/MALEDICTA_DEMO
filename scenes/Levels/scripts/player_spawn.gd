extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	if PlayerManager.player_spawn == false:
		PlayerManager.set_player_position(global_position)
		PlayerManager.player_spawn = true
	pass # Replace with function body.
