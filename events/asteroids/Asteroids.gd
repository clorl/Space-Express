extends Node2D

onready var asteroid = preload("res://events/asteroids/Asteroid.tscn")

func _ready():
	generate()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		$AnimationPlayer.play("default")

func generate():
	for i in range(200):
		var instance = asteroid.instance()
		
		# Random pos
		instance.position = Vector2(rand_range(0,610), rand_range(0,1080*2))
		
		# Random scale		
		var rnd_scale = rand_range(0.2,0.5)
		instance.scale = Vector2(rnd_scale, rnd_scale)
		
		# Random rot
		instance.rotation = rand_range(0,360)
		
		# Random flip
		if randi()%2 == 0:
			instance.flip_h = true
		if randi()%2 == 0:
			instance.flip_h = false
		
		add_child(instance)