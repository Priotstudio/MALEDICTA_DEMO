class_name state_idle extends State

var SPEED : float = 3.0
@onready var walking: State = $"../walking"
@onready var running: State = $"../running"
@onready var kicking: State = $"../kicking"
@onready var animation_player: AnimationPlayer = $"../../visuals/mixamo_base1/AnimationPlayer"


# when the player enters this state
func Enter() -> void:
	player.update_animation("idle")
	#player.locked = false
	pass


# when player exist a state
func Exit() -> void:
	pass
	

func Process(_delta : float) -> State:
	
	if Input.is_action_just_pressed("kick"):
			return kicking

	if player.direction != Vector3.ZERO:
		return walking
	
	player.velocity = Vector3.ZERO
	
	player.velocity.x = move_toward(-player.velocity.x, 0, SPEED)
	player.velocity.z = move_toward(-player.velocity.z, 0, SPEED)
	return null
	
	
func Physics (_delta : float) -> State:
	return null
	
	

func HandleInput (_event : InputEvent) -> State:
	if _event.is_action_pressed("kick"):
		return kicking
		#return kicking
	return null
