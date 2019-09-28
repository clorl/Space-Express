extends Control

onready var audio = get_node("/root/Audio")
onready var c = get_node("/root/Constants")

signal event_selected

onready var timer = $Timer 
onready var display_timer = $VBoxContainer/Timer
onready var l_button = $VBoxContainer/HBox/LButton
onready var r_button = $VBoxContainer/HBox/RButton
onready var anim = $Anim

var time setget set_time

func _process(delta):
	display_timer.value = stepify(timer.time_left, 0.01)

func propose_choices(t, e1=false, e2=false):
	if !e1 || !e2:
		e1 = randi()%c.nb_events+1
		e2 = randi()%c.nb_events+1
	set_events(e1, e2)
	time = t
	
	anim.play("fall")
	audio.play("Warning")
	yield(get_tree().create_timer(2.0), "timeout")
	audio.stop("Warning")

func _on_Button_clicked(event):
	# Disable buttons
	r_button.disabled = true
	l_button.disabled = true
	
	# Hide choices
	anim.play_backwards("fall")
	
	# Wait and start event
	yield(get_tree().create_timer(1.0), "timeout")
	emit_signal("event_selected", event)


func set_time(value):
	timer.wait_time = value
	display_timer.max_value = value

func set_events (evt1, evt2):
	r_button.event = evt1
	l_button.event = evt2
