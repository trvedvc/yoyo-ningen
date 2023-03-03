extends KinematicBody2D


onready var health = 5
onready var speed = 35

var player: Node2D

var velocity: Vector2

var hit = false
var hit_timer = 0
var yoyo: Node2D
var floating_dmg = preload("res://src/scenes/FloatingDMG.tscn")
var item_scene = preload("res://src/scenes/Item.tscn")

func _ready():
	player = get_parent().get_node("Player")

func _physics_process(delta):
	velocity = Vector2.ZERO
	velocity += position.direction_to(player.global_position) * speed
	velocity = move_and_slide(velocity)
	
func _process(delta):
	if hit:
		if hit_timer > 1:
			hit_timer = 0
			
		if hit_timer == 0:
			health -= yoyo.dmg
			var text = floating_dmg.instance()
			text.amount = yoyo.dmg
			add_child(text)
		
		hit_timer += delta
	else:
		if hit_timer != 0 and hit_timer < 1:
			hit_timer += delta
			
	if health <= 0:
		var item = item_scene.instance()
		item.position = position
		find_parent("World").add_child(item)
		queue_free()

func _on_Hurtbox_area_entered(area):
	hit = true
	yoyo = area.get_parent()

func _on_Hurtbox_area_exited(_area):
	hit = false
