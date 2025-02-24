class_name state_run extends State

var SPEED : float = 3.0
var walking_speed : float = 3.0
@export var running_speed : float = 5.0

@onready var idle: state_idle = $"../idle"
@onready var walking: State = $"../walking"
@onready var kicking: state_kick = $"../kicking"


var running : bool = false


# when the player enters this state
func Enter() -> void:
	player.update_animation("running")
	running = true
	
	pass
	


# when player exist a state
func Exit() -> void:
	running = false
	pass
	

func Process(_delta : float) -> State:
	player.velocity.x = player.direction.x * running_speed
	player.velocity.z = player.direction.z * running_speed
	if Input.is_action_pressed("run"):
		running = true
	else:
		SPEED = walking_speed 
		running = false
	if running == false:
		if player.direction == Vector3.ZERO:
			running = false
			return idle
		else:
			if Input.is_action_just_pressed("kick"):
				return kicking
			return walking
	
	# check again if the player is moving while in runstate
	if ! player.direction:
		return idle
	
	return null
	
	
func Physics (_delta : float) -> State:
	return null
	

func HandleInput (_event : InputEvent) -> State:
	return null
	
