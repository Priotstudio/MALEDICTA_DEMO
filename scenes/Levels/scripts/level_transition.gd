@tool
class_name LevelTrasition extends Area3D

enum SIDE {LEFT, RIGHT, TOP, BOTTOM}

@export_file("*.tscn") var level
@export var target_tansition_area : String = "LevelTransition"


@onready var collision_shape: CollisionShape3D = $CollisionShape3D


@export var side : SIDE = SIDE.LEFT:
	set(_v):
		side = _v
		#_update_area()
		
@export_range(1,12,1, "or_greater") var size : int = 2:
	set(_v):
		size = _v
		#_update_area()




# Called when the node enters the scene tree for the first time.
func _ready():
	#_update_area()
	if Engine.is_editor_hint():
		return
		
	monitoring = false
	_place_player()
	
	await LevelManager.level_loaded
	
	monitoring = true
	
	body_entered.connect(_player_entered)
	
	pass 
	
	
func _player_entered (_P : Node3D)-> void:
	# Do somethings with level manager
	LevelManager.load_new_level(level, target_tansition_area, get_offset())
	pass
	
	
func _place_player () -> void :
	if name != LevelManager.target_transition:
		return
	PlayerManager.set_player_position(global_position + LevelManager.position_offset)
	
func get_offset ()-> Vector3:
	var offset : Vector3 = Vector3.ZERO
	var player_pos = PlayerManager.player.global_position
	if side == SIDE.LEFT:
		offset = Vector3(0,0,5)
		offset.y = player_pos.y
	elif side == SIDE.RIGHT:
		offset = Vector3(0,0,-5)
	return offset
