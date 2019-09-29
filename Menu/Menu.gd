extends Control
onready var Popup = $Popup
<<<<<<< HEAD
=======

>>>>>>> Score
signal scene_changed()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func change_scene(path, delay = 0.5):
	yield(get_tree().create_timer(delay), "timeout")
	assert(get_tree().change_scene(path) == OK)

func _on_Play_pressed():
	change_scene("res://Game.tscn")

func _on_Credits_pressed():
<<<<<<< HEAD
	Popup.popup()
=======
	$Popup.popup()
>>>>>>> Score
	



func _on_Croix_pressed():
	$Popup.visible = false


func _on_Titre_animation_started(anim_name):
	$Bruit.play()	
	
