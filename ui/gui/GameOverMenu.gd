extends VBoxContainer

onready var audio = get_node("/root/Audio")
onready var sc = get_node("/root/SceneChanger")

func _on_Restart_pressed():
	sc.change_scene("res://Game.tscn", 0.1)
	audio.play("Select")

func _on_Menu_pressed():
	sc.change_scene("res://menu/Menu.tscn", 0.1)
	audio.play("Select")

func _on_Button_mouse_entered():
	audio.play("Blip")
