extends Position2D

var dmg = 2

var life = 3

func _process(delta):
	
	life -= delta

	if life <= 0:
		queue_free()
