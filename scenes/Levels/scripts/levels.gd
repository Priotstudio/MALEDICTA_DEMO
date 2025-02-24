extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.level_load_started.connect(_free_level)
	pass # Replace with function body.

func _free_level ()-> void:
	#PlayerManager.un_parent_player(self)
	queue_free()
