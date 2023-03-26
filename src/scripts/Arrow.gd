extends KinematicBody2D


var velocity: Vector2
var speed = 35
var life = 0
var direction: Vector2
var id = "arrow"
var bounced = false

func _process(delta):
	if life > 5:
		queue_free()
	life += delta

func _physics_process(delta):
	velocity = move_and_slide(velocity)

func _on_Hitbox_area_entered(area):
	var source = area.get_parent()
	if source.id == "yoyo":
		bounced = true
		life = 0
		$Sprite.frame = 1
		
		direction = global_position - source.global_position
		direction = direction.normalized()
		
		if source.rotation_dir == gv.CW:
			velocity = Vector2(-direction.y, direction.x) + direction
		else:
			velocity = Vector2(direction.y, -direction.x) + direction
		
		velocity *= source.rotation_spd * 4
		rotation = velocity.angle()# + PI
	
