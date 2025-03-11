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
var smoothing_factor := 5.0  # Smoothing factor for movement

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var fall_multiply : float = 200.0

func _ready() -> void:
	state_machine.Initialize(self)
	# For capturing the mouse to move the camera
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * horizontal))
		visuals.rotate_y(deg_to_rad(event.relative.x * horizontal))
		camera_mouse.rotate_x(deg_to_rad(-event.relative.y * vertical))
		# Limit the max and min level you can rotate the camera
		camera_mouse.rotation.x = clamp(camera_mouse.rotation.x, deg_to_rad(min_range_below), deg_to_rad(max_range_above))

func dpad_camera_control(delta) -> void:
	var cam_rotation_speed : float = 200.0
	# For rotating the camera around player using the Dpad
	if Input.is_action_pressed("camera_left"):
		rotate_y(deg_to_rad(delta * cam_rotation_speed))
		visuals.rotate_y(deg_to_rad(-delta * cam_rotation_speed))
		camera_mouse.rotate_x(deg_to_rad(delta * vertical))
	elif Input.is_action_pressed("camera_right"):
		rotate_y(deg_to_rad(-delta * cam_rotation_speed))
		visuals.rotate_y(deg_to_rad(delta * cam_rotation_speed))
		camera_mouse.rotate_x(deg_to_rad(-delta * vertical))
	elif Input.is_action_pressed("camera_up"):
		camera_mouse.rotate_x(deg_to_rad(delta * cam_rotation_speed))
		camera_mouse.rotation.x = clamp(camera_mouse.rotation.x, deg_to_rad(min_range_below), deg_to_rad(max_range_above))
	elif Input.is_action_pressed("camera_down"):
		camera_mouse.rotate_x(deg_to_rad(-delta * cam_rotation_speed))
		camera_mouse.rotation.x = clamp(camera_mouse.rotation.x, deg_to_rad(min_range_below), deg_to_rad(max_range_above))

func _physics_process(delta) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y -= fall_multiply * delta  # Ensure gravity is frame-rate independent

	# Move the player
	move_and_slide()

	# Handle camera control
	dpad_camera_control(delta)

func _process(delta: float) -> void:
	# Get the raw input direction
	var raw_direction = Vector3(
		Input.get_axis("left", "right"),
		0,
		Input.get_axis("up", "down")
	).normalized()
	
	if raw_direction == Vector3.ZERO:
		direction = Vector3.ZERO
	else:
		# Smoothly interpolate the current direction towards the target direction
		direction = direction.lerp(transform.basis * raw_direction, smoothing_factor * delta)

	# Update the visuals to face the movement direction
	if global_transform.origin != position + direction:
		visuals.look_at(position + direction)

func update_animation(State : String) -> void:
	animation.play(State)
