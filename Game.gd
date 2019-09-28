extends Node2D

onready var audio = get_node("/root/Audio.tscn")

const events = {
	asteroids = preload("res://events/asteroids/Asteroids.tscn")
	}

func _on_NextTimer_timeout():
	pass # Replace with function body.

func asteroids():
	var instance = events.asteroids.instance()
	instance.global_position = Vector2(0,-1080)
	add_child(instance)