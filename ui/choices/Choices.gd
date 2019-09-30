extends Control

onready var audio = get_node("/root/Audio")
onready var c = get_node("/root/Constants")

signal event_selected

onready var timer = $Timer 
onready var display_timer = $VBoxContainer/Timer
onready var l_button = $VBoxContainer/HBox/LButton
onready var r_button = $VBoxContainer/HBox/RButton
onready var anim = $Anim

func _ready():
	anim.play("fall")
	anim.stop()

func _process(delta):
	display_timer.value = stepify(timer.time_left, 0.01)

func propose_choices(t, e1=false, e2=false):
	reset()
	if !e1 || !e2:
		e1 = generate_event()
		e2 = generate_event(e1)
	set_events(e1, e2)
	
	set_time(t)
	timer.start()
	
	anim.play("fall")
	audio.play("Warning")
	yield(get_tree().create_timer(2.0), "timeout")
	audio.stop("Warning")

func _on_Button_clicked(event):
	# Disable buttons
	r_button.disabled = true
	l_button.disabled = true
	timer.stop()
	
	# Hide choices
	anim.play_backwards("fall")
	
	# Wait and start event
	yield(get_tree().create_timer(1.0), "timeout")
	emit_signal("event_selected", event)


func reset():
	r_button.reset()
	l_button.reset()

func set_time(value):
	if value > 0:
		timer.wait_time = value
	else: timer.wait_time = 1
	display_timer.max_value = value

func set_events (evt1, evt2):
	r_button.event = evt1
	l_button.event = evt2

# If player not quick enough
func _on_Timer_timeout():
	var rnd = randi()%2
	if rnd == 0:
		r_button._on_ChoiceButton_pressed()
	else:
		l_button._on_ChoiceButton_pressed()

func generate_event(pe=-1):
	var e
	randomize()
	e = randi()%(c.nb_events-1)
	while !(pe != e || e == c.unknown):
		e = int(rand_range(0,c.nb_events-1))
	return e
