extends KinematicBody2D


export var health: int
export var speed: int

var player: Node2D

var velocity: Vector2

var dmg_timer = 0
var hit: bool

func _ready():
	player = get_parent().get_node("Player")
	

func _physics_process(delta):
	velocity = Vector2.ZERO
	velocity += position.direction_to(player.global_position) * speed
	velocity = move_and_slide(velocity)
	

func _on_Hurtbox_area_entered(area):
	hit = true
