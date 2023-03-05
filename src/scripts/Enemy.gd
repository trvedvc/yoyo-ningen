extends KinematicBody2D


onready var health = 500
onready var speed = 25

var player: Node2D

var velocity: Vector2

var hit = false
var hit_timer = 0
var floating_dmg = preload("res://src/scenes/FloatingDMG.tscn")
var item_scene = preload("res://src/scenes/Item.tscn")
var dmg_sources = []
var dmg_taken = 0

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
		
		for source in dmg_sources:
			dmg_taken += source.dmg
			
		if hit_timer == 0:
			health -= dmg_taken
			var text = floating_dmg.instance()
			text.amount = dmg_taken
			text.position = global_position
			find_parent("World").add_child(text)
		
		hit_timer += delta
		dmg_taken = 0
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
	dmg_sources.append(area.get_parent())
	# TODO make this better and actually playable

func _on_Hurtbox_area_exited(area):
	hit = false
	dmg_sources.erase(area.get_parent()) # ?? xdd
