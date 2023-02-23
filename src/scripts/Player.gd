extends KinematicBody2D

var speed = 100
var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO

func _physics_process(delta):
	velocity = Vector2()
	
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector * speed
		
	velocity = move_and_slide(velocity)
	
