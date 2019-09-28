extends Control
onready var Popup = $Credits
signal scene_changed()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func change_scene(path, delay = 0.5):
	yield(get_tree().create_timer(delay), "timeout")
	assert(get_tree().change_scene(path) == OK)

func _on_Play_pressed():
	change_scene("res://ui/GUI.tscn")


func _on_Credits_pressed():
	Popup.ready()
	print(Popup.visible)
	

