extends Node2D

var enemy_scene = preload("res://src/scenes/Enemy.tscn")
onready var world = get_parent()

export var wait_timer: float

func _ready():
	$Timer.wait_time = wait_timer


func _on_Timer_timeout():
	var enemy = enemy_scene.instance()
	world.get_node("YSort").add_child(enemy)
	enemy.global_position = position

