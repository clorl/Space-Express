extends Sprite

func _ready():
	randomize()

	if randi()%1000 == 0:
		frame = 3
	else:
		randomize()
		frame = randi()%3