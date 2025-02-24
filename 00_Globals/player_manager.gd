extends Node

const PLAYER = preload("res://scenes/player.tscn")

var player: Player
var player_spawn : bool = false


func _ready() -> void:
	add_player_instance()
	await get_tree().create_timer(0.2).timeout
	player_spawn == true


func add_player_instance ( )-> void:
	player = PLAYER.instantiate()
	add_child(player)
	pass
	
func set_player_position (_new_pos : Vector3) -> void:
	await get_tree().process_frame
	player.global_position = _new_pos
	pass
	
