extends Popup

onready var audio = get_node("/root/Audio")


func _on_Quit_mouse_entered():
	audio.play("Blip")


func _on_Quit_pressed():
	audio.play("Select")
	visible = false
