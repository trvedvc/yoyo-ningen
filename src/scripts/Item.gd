extends Node2D

var drop = true

func _ready():
	$Sprite.frame = randi() % 2
