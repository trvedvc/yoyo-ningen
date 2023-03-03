extends Panel

var item_scene = preload("res://src/scenes/Item.tscn")
var item = null
onready var inventory = find_parent("Inventory")

export var type: String

func pick_from_slot():
	remove_child(item)
	inventory.add_child(item)
	item = null
	
func put_into_slot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	inventory.remove_child(item)
	add_child(item)
