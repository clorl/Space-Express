extends Sprite

onready var sprite = self
var rotate_clockwise

func _ready():
	randomize()
	global_rotation_degrees = rand_range(0,360)
	rotate_clockwise = bool(randi()%2)

func _process(delta):
	if rotate_clockwise:
		global_rotation_degrees += delta*5
		if global_rotation_degrees >= 360:
			global_rotation_degrees-=360
	else:
		global_rotation_degrees -= delta*5
		if global_rotation_degrees <= 0:
			global_rotation_degrees+=360