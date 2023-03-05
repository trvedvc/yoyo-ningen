extends KinematicBody2D

export var speed: int
export var dmg: int

var mouse_pos: Vector2
var velocity: Vector2

var flame_scene = preload("res://src/scenes/Flame.tscn")
const spell_delay = 0.2
var cur_spell_delay = 0
const cooldown = 6
var cur_cooldown = 0
const casted_spells = 5
var cur_casted_spells = 0

var cast_spell = false
var process_cooldown = false

var hit: bool

onready var world = find_parent("World")

# TODO invert border polygon2d range collision
# idk if it works 
# mayhaps better ways to do but whatever
# flexible range, if game popular
# oh no maths

func _process(delta):
	rotation += 10 * delta
	
	if Input.is_action_just_pressed("spell"):
		if cur_cooldown <= 0: 
			cur_cooldown = cooldown
			cast_spell = true
			process_cooldown = true
	
	# TODO perhaps use line2d and not his funny thing
	if cast_spell == true:
		if cur_spell_delay <= 0:
			var flame = flame_scene.instance()
			flame.position = global_position
			world.add_child(flame)
			cur_spell_delay = spell_delay
			cur_casted_spells += 1
		else:
			cur_spell_delay -= delta
			
		if cur_casted_spells == casted_spells:
			cur_casted_spells = 0
			cur_spell_delay = 0
			cast_spell = false
			
	if process_cooldown:
		if cur_cooldown > 0:
			cur_cooldown -= delta
		else:
			print("cd")
			process_cooldown = false
	
func _physics_process(delta):
	velocity = Vector2.ZERO
	mouse_pos = get_global_mouse_position()
	
	velocity += position.direction_to(mouse_pos) * speed
	
	if (abs(mouse_pos.x - position.x) < 1 and abs(mouse_pos.y - position.y) < 1):
		return

	velocity = move_and_slide(velocity)
	

