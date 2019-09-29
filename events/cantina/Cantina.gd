extends Node2D
onready var sprite = $Sprite
var rotate_clockwise

func _ready():
	randomize()
	sprite.global_rotation_degrees = rand_range(0,360)
	rotate_clockwise = bool(randi()%2)

func _process(delta):
	if rotate_clockwise:
		sprite.global_rotation_degrees += delta*5
		if sprite.global_rotation_degrees >= 360:
			sprite.global_rotation_degrees-=360
	else:
		sprite.global_rotation_degrees -= delta*5
		if sprite.global_rotation_degrees <= 0:
			sprite.global_rotation_degrees+=360