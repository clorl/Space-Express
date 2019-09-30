extends ColorRect

signal scene_changed()
# Called when the node enters the scene tree for the first time.
func _ready():
	OS.window_maximized = true

func _on_logo_animation_finished(anim_name):
	get_tree().change_scene("res://menu/Menu.tscn")
