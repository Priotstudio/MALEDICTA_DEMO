class_name MiniMap extends ColorRect

@export var target : NodePath
@export var camera_distance := 20.0

# Objective and texture pairing
@export var objective_nodes: Array[Node3D]  # Array of 3D objectives in the world
@export var objective_textures: Array[Texture]  # Array of textures for each objective

@onready var player := PlayerManager.player
@onready var camera := $SubViewportContainer/SubViewport/Camera3D
@onready var indicator := $indicator
@onready var minimap := $"."  # Reference to the minimap itself
var markers = {}  # Store markers for objectives

func _ready():
	# Make sure the number of objectives matches the number of textures
	if objective_nodes.size() != objective_textures.size():
		push_error("Objective nodes and textures arrays must have the same length!")
		return
	
	# Create markers for each objective
	for i in range(objective_nodes.size()):
		var objective = objective_nodes[i]
		var texture = objective_textures[i]
		
		var marker = TextureRect.new()
		marker.texture = texture
		marker.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
		marker.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		marker.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		marker.custom_minimum_size = Vector2(35, 35)
		minimap.add_child(marker)  # Add the marker to the minimap
		markers[objective] = marker  # Store the marker reference

func _process(delta: float) -> void:
	update_minimap_markers()

	# Handle camera positioning and rotation
	if target:
		camera.size = camera_distance
		camera.position = Vector3(player.position.x, camera_distance, player.position.z)
		camera.rotation.z = player.rotation.y

# Function to update the minimap markers based on objective positions
func update_minimap_markers():
	if not camera:
		return
	
	var minimap_size = minimap.get_rect().size  # Correct way to get size

	for objective in objective_nodes:
		if not objective or not markers.has(objective):
			continue

		var marker = markers[objective]

		# Convert 3D position to 2D minimap position
		var screen_pos = camera.unproject_position(objective.global_transform.origin)

		# Scale to minimap coordinates
		screen_pos.x = (screen_pos.x / minimap_size.x) * minimap_size.x
		screen_pos.y = (screen_pos.y / minimap_size.y) * minimap_size.y

		# Clamp within minimap bounds
		var center = minimap_size / 2
		var direction = (screen_pos - center).normalized()
		var distance = center.distance_to(screen_pos)
		var max_distance = minimap_size.length() / 2

		if distance > max_distance:
			screen_pos = center + (direction * max_distance)

		marker.position = screen_pos - (marker.size / 2)
