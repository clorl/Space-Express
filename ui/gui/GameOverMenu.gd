extends VBoxContainer

onready var sc = get_node("/root/SceneChanger")

func _on_Restart_pressed():
	sc.change_scene("res://Game.tscn", 0.1)

func _on_Menu_pressed():
	sc.change_scene("res://menu/Menu.tscn", 0.1)