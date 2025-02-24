class_name state_walk extends State

@export var SPEED : float = 3.0
const JUMP_VELOCITY : float = 4.5

@onready var idle : State = $"../idle"
@onready var running: State = $"../running"



# when the player enters this state
func Enter() -> void:
	player.update_animation("walking")
	pass


# when player exist a state
func Exit() -> void:
	pass
	

func Process(_delta : float) -> State:
	if player.direction == Vector3.ZERO:
		return idle
	
	if Input.is_action_pressed("run"):
		return running
	
	player.velocity.x = player.direction.x * SPEED
	player.velocity.z = player.direction.z * SPEED
	
	return null
	
	
func Physics (_delta : float) -> State:
	return null
	

func HandleInput (_event : InputEvent) -> State:
	return null
