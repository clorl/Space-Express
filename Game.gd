extends Node2D

export var event_number = 10
var event_index = 1

onready var audio = get_node("/root/Audio")
onready var c = get_node("/root/Constants")

onready var cam_anim = $Background/Camera2D/CamAnim
onready var overlay_anim = $Warning/Anim
onready var bg = $Background/Camera2D/BG

onready var choices = $Choice/Choices
onready var player = $Player

const nodes = {
	"asteroids": preload("res://events/asteroids/Asteroids.tscn")
	}

func _ready():
	yield(get_tree().create_timer(2), "timeout")
	choices.propose_choices(10, c.asteroids, c.contraband)
	overlay_anim.play("warning")

# When choice has been made
func _on_Choices_event_selected(event):
	execute_event(event)

# Function that manages which function to call
func execute_event(e):
	match e:
		c.unknown:
			pass
		c.asteroids:
			asteroids()
		c.cantina:
			pass
		c.pirate:
			pass
		c.contraband:
			pass
		c.repair:
			pass
		c.nothing:
			pass
	yield(get_tree().create_timer(2), "timeout")
	if event_index == event_number:
		return
	event_index += 1
	
	choices.propose_choices(10)

##
# Event functions
##

func asteroids():
	# Add asteroids
	var instance = nodes.asteroids.instance()
	instance.global_position = Vector2(0,0)
	add_child(instance)
	
	# Wait a bit and animate
	yield(get_tree().create_timer(0.5), "timeout")
	player.health -= 20
	cam_anim.play("screenshake")