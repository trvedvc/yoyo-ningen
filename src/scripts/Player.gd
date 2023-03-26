extends KinematicBody2D

export var speed: int
var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO
var direction = false
var id = "player"

onready var animation_player = $AnimationPlayer
onready var yoyo = get_parent().get_node("Yoyo")

func _physics_process(delta):
	velocity = Vector2()
	
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector = input_vector.normalized()
	
	if yoyo.position.x > position.x:
		direction = gv.RIGHT
	else: direction = gv.LEFT
	$MageSpritesheet.set_flip_h(direction)
	# perhaps backwards movement spirtes
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector * speed
		animation_player.play("walk")
	else:
		animation_player.play("idle")
	
		
	velocity = move_and_slide(velocity)


