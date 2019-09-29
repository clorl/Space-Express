extends ColorRect

signal scene_changed()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func change_scene(path, delay = 0.5):
	yield(get_tree().create_timer(delay), "timeout")
	assert(get_tree().change_scene(path) == OK)

func _on_logo_animation_finished(anim_name):
	change_scene("res://Menu/Menu.tscn")
