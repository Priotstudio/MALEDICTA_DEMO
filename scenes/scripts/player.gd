class_name Player extends CharacterBody3D


@onready var camera_mouse : Node3D = $camera_mouse
@onready var animation : AnimationPlayer = $visuals/mixamo_base1/AnimationPlayer
@onready var visuals : Node3D = $visuals
@onready var state_machine: PlayerStateMAchine = $StateMachine


@export var horizontal : float = 0.5
@export var vertical : float = 0.5


var running : bool = false
var direction : Vector3 = Vector3.ZERO
var min_range_below : float = -40.5
var max_range_above : float = 40.5



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var fall_multiply : float = 0


func _ready() -> void:
	state_machine.Initialize(self)
	# For capturin the mouse to move the camera
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

	
func _input(event) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * horizontal))
		visuals.rotate_y(deg_to_rad(event.relative.x * horizontal))
		camera_mouse.rotate_x(deg_to_rad(-event.relative.y * vertical))
		#visuals.look_at(position + direction)
		
		# limit the max and min level you can rotate the camera
		camera_mouse.rotation.x = clamp(camera_mouse.rotation.x, deg_to_rad(min_range_below), deg_to_rad(max_range_above))



func _physics_process(delta) -> void:
	# gravity to pul player down
	if not is_on_floor():
		velocity.y =  velocity.y - fall_multiply
	move_and_slide()



func _process(delta: float) -> void:
	direction = transform.basis * Vector3(
		Input.get_axis("ui_left", "ui_right"),
		0,
		Input.get_axis("ui_up", "ui_down")
	).normalized()
	
	if global_transform.origin != position + direction:
		visuals.look_at(position + direction)
	pass
	

	
func update_animation(State : String)-> void:
	animation.play(State)
	pass
	
