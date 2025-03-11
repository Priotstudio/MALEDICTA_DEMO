extends CanvasLayer

signal  shown
signal  hidden

@onready var resume_button: Button = $VBoxContainer/Button
@onready var inventory_button: Button = $VBoxContainer/Button2
@onready var options_button: Button = $VBoxContainer/Button3
@onready var quit_button: Button = $VBoxContainer/Button4
@onready var animation_player: AnimationPlayer = $AnimationPlayer2
@onready var back_button: Button = $inventory/back_button
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var label: Label = $Label
@onready var overlay: TextureRect = $overlay
@onready var inventory: Control = $inventory
@onready var item_description: Label = $inventory/item_description
@onready var overlay_2: TextureRect = $inventory/overlay2
@onready var title: Label = $inventory/Title



var is_paused := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	hide_pause()
	resume_button.pressed.connect(_on_resume_pressed)
	inventory_button.pressed.connect(_on_iventory_pressed)
	back_button.pressed.connect(show_pause)
	pass # Replace with function body.


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_paused == false:
			show_pause()
		else:
			hide_pause()
			
		get_viewport().set_input_as_handled()
	pass
	
 
func show_pause() -> void:
	
	# to show buttons of the pause menue
	v_box_container.visible = true
	label.visible = true
	overlay.visible = true
	inventory.visible = false
	item_description.visible = false
	overlay_2.visible = false
	title.visible = false
	
	
	
	get_tree().paused = true
	visible = true
	is_paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	animation_player.play("transition_in")
	back_button.visible = false
	resume_button.grab_focus()
	shown.emit()
	

func hide_pause () -> void:
	get_tree().paused = false
	animation_player.play("transition_out")
	await animation_player.animation_finished
	visible = false
	is_paused = false
	
	#animation_player.play("transition_in")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	hidden.emit()

func _on_resume_pressed () -> void:
	if is_paused == false:
		return
	hide_pause()	
		
func _on_iventory_pressed () -> void:
	v_box_container.visible = false
	label.visible = false
	overlay.visible = false
	animation_player.play("transition_in")
	back_button.visible = true
	inventory.visible = true
	item_description.visible = true
	overlay_2.visible = true
	title.visible = true
	
	back_button.grab_focus()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	shown.emit()
	
func update_item_decription (new_text : String) -> void:
	item_description.text = new_text
	
