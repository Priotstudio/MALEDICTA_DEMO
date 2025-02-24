class_name State extends Node

# stroes refrence to our player
static  var player: Player
static  var state_machine: PlayerStateMAchine

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func init() -> void:
	pass


# when the player enters this state
func Enter() -> void:
	pass


# when player exist a state
func Exit() -> void:
	pass
	

func Process(_delta : float) -> State:
	return null
	
	
func Physics (_delta : float) -> State:
	return null
	

func HandleInput (_event : InputEvent) -> State:
	return null
