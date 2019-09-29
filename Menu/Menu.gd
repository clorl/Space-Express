extends Control
onready var Popup = $CanvasLayer/Popup2

onready var sc = get_node("/root/SceneChanger")

func _ready():
	pass

func _on_Play_pressed():
	sc.change_scene("res://Game.tscn", 0.1)

func _on_Credits_pressed():
	Popup.popup()

func _on_Croix_pressed():
	Popup.visible = false


func _on_Titre_animation_started(anim_name):
	$Bruit.play()	
	
