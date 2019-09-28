extends TextureButton

onready var audio = get_node("/root/Audio")
onready var icon = $Sprite

signal clicked
var event setget set_event

func _on_ChoiceButton_pressed():
	$Anim.play("click")
	audio.play("Select")
	emit_signal("clicked", event)

func set_event(e):
	event = e
	icon.frame = e

func _on_ChoiceButton_mouse_entered():
	audio.play("Blip")
