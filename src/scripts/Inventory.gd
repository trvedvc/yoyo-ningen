extends Node2D

const slot_class = preload("res://src/scripts/Slot.gd")
onready var slots = $Container
var holding_item = null

func _ready():
	for slot in slots.get_children():
		slot.connect("gui_input", self, "slot_gui_input", [slot])
		
# TODO copied, learn how this works
func slot_gui_input(event: InputEvent, slot: slot_class):
	if visible:
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT && event.pressed:
				if holding_item != null:
					if !slot.item:
						slot.put_into_slot(holding_item)
						holding_item = null
					else:
						var temp_item = slot.item
						slot.pick_from_slot()
						temp_item.global_position = event.global_position
						slot.put_into_slot(holding_item)
						holding_item = temp_item
				elif slot.item:
					holding_item = slot.item
					slot.pick_from_slot()
					holding_item.global_position = get_global_mouse_position()

func _input(event):
	if visible:
		if holding_item:
			holding_item.global_position = get_global_mouse_position()
