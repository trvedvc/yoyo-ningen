extends KinematicBody2D

onready var health = 500
onready var speed = 25 #25
var id = "enemy"

var velocity: Vector2
var direction: Vector2

var floating_dmg = preload("res://src/scenes/FloatingDMG.tscn")
var cc = 1
var yoyoed = 0
var got_yoyoed = false
var yoyo_on_hit_position: Vector2
var hit = false
var friction = 1
var friction_tmr = 0

var reload = 0
var arrow_scene = preload("res://src/scenes/Arrow.tscn")
var player_in_range = false
var state = "walk"

onready var player = get_parent().get_node("Player")
onready var yoyo = get_parent().get_node("Yoyo")

func _process(delta):
	if state == "shoot":
		if reload > 3: # HACK, timer node or sth
			var arrow = arrow_scene.instance()
			arrow.position = global_position
			arrow.velocity = position.direction_to(player.global_position) * arrow.speed
			arrow.rotation = arrow.velocity.angle()
			get_parent().add_child(arrow)
			reload = 0
	
	if reload < 3:		
		reload += delta


func _physics_process(delta):
	velocity = Vector2.ZERO
	
	if state == "walk":
		velocity = position.direction_to(player.global_position) * speed
	
	if got_yoyoed:
		got_yoyoed = false
		yoyoed = cc
		
	if yoyoed > 0:
		if yoyo.rotation_dir == gv.CW:
			velocity = Vector2(-direction.y, direction.x) + direction
		else:
			velocity = Vector2(direction.y, -direction.x) + direction
	
		velocity *= yoyo.rotation_spd * 4 * friction
		yoyoed -= delta
	
	friction_tmr += delta
		
	if friction_tmr > 0.2:
		friction -= 0.2
		friction_tmr = 0
		
	velocity = move_and_slide(velocity)

func _on_Hurtbox_area_entered(area):
	var source = area.get_parent()
	if source.id == "yoyo":
		got_yoyoed = true
		friction = 1
		direction = global_position - yoyo.global_position
		direction = direction.normalized()
		
	if source.id == "arrow":
		if source.bounced:
			queue_free()
			source.queue_free()
	

func _on_Range_area_entered(area):
	player_in_range = true
	state = "shoot"


func _on_Range_area_exited(area):
	player_in_range = false
	state = "walk"
