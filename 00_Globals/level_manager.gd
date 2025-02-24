extends Node


signal level_load_started
signal level_loaded

var current_tilemap_bounds : Array [Vector3]
signal TileMapBoundsChanged (bounds : Array [Vector3])
var target_transition : String
var position_offset : Vector3


func _ready() -> void:
	await  get_tree().process_frame
	level_loaded.emit()

func change_tileMap_bounds (bounds : Array [Vector3]) -> void:
	current_tilemap_bounds = bounds
	TileMapBoundsChanged.emit(bounds)


func load_new_level (
		level_path : String,
		_target_transition : String,
		_position_offset : Vector3
) -> void:
	
	#
	get_tree().paused = false
	target_transition = _target_transition
	position_offset = _position_offset
	#
	
	await InGameLoading.loading()
	#await SceneTransition.fade_out() # level transition
	#
	level_load_started.emit()
	#
	
	
	
	
	await get_tree().process_frame
	#
	get_tree().change_scene_to_file(level_path)
	#
	#await SceneTransition.fade_in() # level transmition
	#
	get_tree().paused = false
	#
	await get_tree().process_frame
	#
	level_loaded.emit()
	await get_tree().process_frame
	await  InGameLoading.default()

	#
	pass
