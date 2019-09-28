extends Control

onready var timer = $Timer
onready var display_timer = $VBoxContainer/Timer

enum {
	asteroids
	pirate
	contraband
	}

func _ready():
	set_max_value(timer.time_left)
	
func _process(delta):
	display_timer.value = stepify(timer.time_left, 0.01)

func set_max_value(value):
	display_timer.max_value = value

func propose_choices():
	pass