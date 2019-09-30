extends Popup

onready var sc = get_node("/root/SceneChanger")
onready var audio = get_node("/root/Audio")

func blip():
	audio.play("Blip")


func _on_Continue_pressed():
	audio.play("Select")
	visible = false
	get_tree().paused = false


func _on_Quit_pressed():
	audio.play("Select")
	sc.change_scene("res://menu/Menu.tscn", 0.1)
	get_tree().paused = false


func _on_PauseButton_pressed():
	get_tree().paused = true
	audio.play("Select")
	popup()
