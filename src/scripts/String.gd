extends Line2D
	
onready var yoyo = get_parent().get_node("YSort/Yoyo")
onready var player = get_parent().get_node("YSort/Player")

var face = 1

func _ready():
	default_color = Color.white
	width = 1

func _process(delta):
	clear_points()
	
	if player.direction == gv.LEFT:
		face = -1
	else: face = 1
	
	add_point(player.position + Vector2(5 * face,-4))
	add_point(yoyo.position)
