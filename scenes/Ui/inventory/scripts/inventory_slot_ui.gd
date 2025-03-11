class_name InventorySlotUi extends Button

var slot_data: SlotData : set = set_slot_data

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label


func _ready() -> void:
	# Initialize the slot
	texture_rect.texture = null
	label.text = ""

	# Disconnect existing connections (if any)
	if focus_entered.is_connected(item_focused):
		focus_entered.disconnect(item_focused)
	if focus_exited.is_connected(item_unfocused):
		focus_exited.disconnect(item_unfocused)

	# Connect the signals
	focus_entered.connect(item_focused)
	focus_exited.connect(item_unfocused)


func set_slot_data(value: SlotData) -> void:
	slot_data = value
	if slot_data == null:
		texture_rect.texture = null
		label.text = ""
		return
	texture_rect.texture = slot_data.item_data.texture
	label.text = str(slot_data.quantity)


func item_focused() -> void:
	if slot_data != null and slot_data.item_data != null:
		PauseMenu.update_item_decription(slot_data.item_data.decription)


func item_unfocused() -> void:
	PauseMenu.update_item_decription("")
