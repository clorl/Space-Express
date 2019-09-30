extends Control

onready var audio = get_node("/root/Audio")


func _on_mouse_entered():
	audio.play("Blip")


func _on_pressed():
	audio.play("Select")
