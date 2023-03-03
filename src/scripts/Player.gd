extends KinematicBody2D

export var speed: int
var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO
var LEFT = true
var RIGHT = false
var direction = false

onready var animation_player = $AnimationPlayer
onready var yoyo = get_parent().get_node("Yoyo")
onready var inventory = find_parent("World").get_node("UI").get_node("Inventory").get_node("Container")

func _physics_process(delta):
	velocity = Vector2()
	
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector = input_vector.normalized()
	
	if yoyo.position.x > position.x:
		direction = RIGHT
	else: direction = LEFT
	$MageSpritesheet.set_flip_h(direction)
	# perhaps backwards movement spirtes
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector * speed
		animation_player.play("walk")
	else:
		animation_player.play("idle")
	
		
	velocity = move_and_slide(velocity)

func _on_PickUpRange_area_entered(area):
	var item = area.get_parent()
	for slot in inventory.get_children():
		if slot.item == null and slot.type == "slot" and item.drop == true:
			item.position = Vector2(0,0)
			item.drop = false
			find_parent("World").remove_child(item)
			slot.item = item
			slot.add_child(item)
			return
			
