extends Node2D

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
	choices.propose_choices(10, c.asteroids, c.contraband)
	overlay_anim.play("warning")

# When choice has been made
func _on_Choices_event_selected(event):
	execute_event(event)

# Function that manages which function to call
func execute_event(e):
	asteroids()

##
# Event functions
##

func asteroids():
	# Add asteroids
	var instance = nodes.asteroids.instance()
	instance.global_position = Vector2(0,0)
	add_child(instance)
	
	player.health -= 20
	cam_anim.play("screenshake")