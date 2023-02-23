extends KinematicBody2D


export var speed: int
export var dmg: int

var mouse_pos: Vector2
var velocity: Vector2

func _physics_process(delta):
	velocity = Vector2.ZERO
	mouse_pos = get_global_mouse_position()	
	
	velocity += position.direction_to(mouse_pos) * speed
	
	if (abs(mouse_pos.x - position.x) < 1 and abs(mouse_pos.y - position.y) < 1):
		return

	velocity = move_and_slide(velocity)

