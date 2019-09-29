extends Control
onready var Popup = $CanvasLayer/Popup2

onready var audio = get_node("/root/Audio")
onready var sc = get_node("/root/SceneChanger")

func _ready():
	pass

func _on_Play_pressed():
	sc.change_scene("res://Game.tscn", 0.1)
	audio.play("Select")

func _on_Credits_pressed():
	Popup.popup()
	audio.play("Select")

func _on_Croix_pressed():
	Popup.visible = false

func _on_mouse_entered():
	audio.play("Blip")


func _on_Titre_animation_finished(anim_name):
	audio.play("Explode")
