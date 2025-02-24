extends MultiMeshInstance3D

@onready var tree: MeshInstance3D = $tree_big

@export var Generation_Num :  int = 0
var item_mesh = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		item_mesh.append(child)
		item_generation()
	pass # Replace with function body.


func item_generation () -> void:
	if Generation_Num > 0:
		var new_node = tree.duplicate()
		add_child(new_node)
	pass
