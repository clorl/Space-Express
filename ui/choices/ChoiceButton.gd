extends TextureButton

onready var c = get_node("/root/Constants")
onready var audio = get_node("/root/Audio")
onready var icon = $Sprite
onready var indicator = $Sprite/Indicators

signal clicked
var event setget set_event

func _on_ChoiceButton_pressed():
	$Anim.play("click")
	audio.play("Select")
	emit_signal("clicked", event)

func set_event(e):
	event = e
	
	icon.frame = e
	if e == c.nothing: 
		icon.frame = 0
		
	indicator.frame = icon.frame

func reset():
	disabled = false
	$Anim.play("idle")

func _on_ChoiceButton_mouse_entered():
	audio.play("Blip")
