class_name state_kick extends State

var locked : bool = false
var SPEED : float = 3.0
var walking_speed : float = 3.0
@export var running_speed : float = 5.0

@onready var idle: State = $"../idle"
@onready var walking: State = $"../walking"
@onready var running: State = $"../running"
@onready var animation: AnimationPlayer = $"../../visuals/mixamo_base1/AnimationPlayer"



# when the player enters this state
func Enter() -> void:
	player.update_animation("kick")
	locked = true
	animation.animation_finished.connect(EndKick)
	

# when player exist a state
func Exit() -> void:
	#animation.animation_finished.disconnect(EndKick)
	locked = false
	pass
	

func Process(_delta : float) -> State:
	if locked:
		return null
		
	if player.direction == Vector3.ZERO:
		return idle
	else:
		return walking
	return null
	
	
func Physics (_delta : float) -> State:
	return null
	

func HandleInput (_event : InputEvent) -> State:
	if _event.is_action_pressed("kick"):
		locked = true
	return null
	
func EndKick(_nameanimation : String) -> void:
	locked = false
	animation.animation_finished.disconnect(EndKick)
