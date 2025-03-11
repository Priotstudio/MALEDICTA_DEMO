extends CSGBox3D

# Reference to the ShaderMaterial
@export var custom_material: ShaderMaterial

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set default values for testing
	custom_material.set("shader_param/light_direction", Vector3(-0.5, -0.5, -0.5))
	custom_material.set("shader_param/light_color", Color(1.0, 1.0, 1.0, 1.0))
	custom_material.set("shader_param/light_intensity", 1.0)
	custom_material.set("shader_param/shadow_strength", 0.5)
	custom_material.set("shader_param/ambient_strength", 0.5)
	custom_material.set("shader_param/ambient_color", Color(0.2, 0.2, 0.2, 1.0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
