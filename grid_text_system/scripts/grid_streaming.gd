class_name GridStreaming extends Node3D

@onready var player: Player = PlayerManager.player
@export var chunks: Array[MeshInstance3D]  # Assign chunks in the editor

var chunk_size: float = 0.0  # Will be detected dynamically
var load_count: int = 1  # Number of chunks to load in each direction
var preload_distance: int = 2  # Distance to preload chunks beyond the player

func _ready() -> void:
	if chunks.size() > 0:
		chunk_size = detect_chunk_size()  # Detect chunk size automatically

func _process(delta: float) -> void:
	if player and chunk_size > 0:
		var player_pos: Vector3 = player.global_transform.origin
		update_chunks(player_pos)  # Update chunks based on player position

func detect_chunk_size() -> float:
	if chunks.size() > 1:
		# Calculate chunk size based on the distance between the first two chunks
		return abs(chunks[1].global_transform.origin.x - chunks[0].global_transform.origin.x)
	return 20.0  # Default fallback if there are not enough chunks

func update_chunks(player_pos: Vector3) -> void:
	# Calculate the current chunk the player is in
	var player_chunk_x: int = int(player_pos.x / chunk_size)
	var player_chunk_z: int = int(player_pos.z / chunk_size)

	# Loop through all chunks and load/unload based on distance
	for chunk in chunks:
		var chunk_pos: Vector3 = chunk.global_transform.origin
		var chunk_x: int = int(chunk_pos.x / chunk_size)
		var chunk_z: int = int(chunk_pos.z / chunk_size)

		# Calculate the distance between the player and the chunk
		var distance_x: int = abs(player_chunk_x - chunk_x)
		var distance_z: int = abs(player_chunk_z - chunk_z)

		# Use Chebyshev distance for diagonal checking
		var distance: int = max(distance_x, distance_z)

		# Load or unload the chunk based on the preload distance
		if distance <= (load_count + preload_distance):  # Preload chunks
			if not chunk.visible:
				chunk.visible = true  # Load the chunk
		elif distance > load_count:
			if chunk.visible:
				chunk.visible = false  # Unload the chunk
