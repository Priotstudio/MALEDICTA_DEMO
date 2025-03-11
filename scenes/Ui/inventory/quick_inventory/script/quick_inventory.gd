extends Control
class_name QuickInventoryUI

@export var inventory_data: IventoryData
@export var item_texture_rect: TextureRect
@export var item_quantity_label: Label

@onready var glow_texture: TextureRect = $TextureRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_player_2: AnimationPlayer = $AnimationPlayer2


var consumable_items: Array[SlotData] = []
var current_index: int = 0
var last_input_time: float = 0.0
var input_cooldown: float = 0.05

var is_glowing: bool = false

func _ready() -> void:
	glow_texture.visible = false
	initialize_inventory()
	
	

func initialize_inventory() -> void:
	consumable_items.clear()
	for slot in inventory_data.slots:
		if slot != null and slot.item_data != null and slot.item_data.is_consumable:
			consumable_items.append(slot)
	current_index = clamp(current_index, 0, max(0, consumable_items.size() - 1))
	update_display()

func update_display() -> void:
	if consumable_items.is_empty():
		item_texture_rect.texture = null
		#item_name_label.text = "No Consumables"
	else:
		var current_slot: SlotData = consumable_items[current_index]
		item_texture_rect.texture = current_slot.item_data.texture
		item_quantity_label.text = str(current_slot.quantity)
		#item_name_label.text = str(current_slot.quantity) + "x " + current_slot.item_data.name
		item_texture_rect.queue_redraw()

func move_left() -> void:
	if consumable_items.is_empty():
		return
	if current_index > 0:
		current_index -= 1
	else:
		current_index = consumable_items.size() - 1
		
	animation_player.play("fade_in_left")
	update_display()

func move_right() -> void:
	if consumable_items.is_empty():
		return
	
	if current_index < consumable_items.size() - 1:
		current_index += 1
	else:
		current_index = 0
	
	animation_player.play("fade_in_right")
	update_display()

func consume_current_item() -> void:
	if consumable_items.is_empty():
		return
	var current_slot: SlotData = consumable_items[current_index]
	if current_slot.quantity > 0:
		current_slot.quantity -= 1
		if current_slot.quantity == 0:
			consumable_items.remove_at(current_index)
			current_index = clamp(current_index, 0, max(0, consumable_items.size() - 1))
		update_display()

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("L1"):
		glow_texture.visible = true
		animation_player_2.play("glow_outline")
		
		if Input.is_action_just_pressed("circle"):
			animation_player.play("fade_out_right")
			Input.action_release("circle")
			move_right()
			
		if Input.is_action_just_pressed("square"):
			animation_player.play("fade_out_left")
			Input.action_release("square")
			move_left()
	else:
		stop_specific_animation("glow_init")
		glow_texture.visible = false
		
func stop_specific_animation(animation_name: String) -> void:
	if animation_player.is_playing() and animation_player.current_animation == animation_name:
		animation_player.stop(true)
		
