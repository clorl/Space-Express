extends HBoxContainer

onready var sc = get_node("/root/SceneChanger")
onready var c = get_node("/root/Constants")
onready var audio = get_node("/root/Audio")

onready var desc_label = $ShipBox/VBoxContainer/Label
onready var img = $ShipBox/VBoxContainer/Ship
onready var anim = $ShipBox/Anim

var cur = 0

func _ready():
	desc_label.text = c.ships_descs[cur]
	img.texture = c.ships_images[cur]

func _on_pressed():
	randomize()
	audio.play_pitch("Blip", rand_range(0.8, 1.2))

func next_ship():
	cur += 1
	cur = cur%c.ships.size()
	desc_label.text = c.ships_descs[cur]
	img.texture = c.ships_images[cur]

func prev_ship():
	cur -= 1
	if cur < 0:
		cur = c.ships.size()-1
	desc_label.text = c.ships_descs[cur]
	img.texture = c.ships_images[cur]

func _on_Left_pressed():
	if !anim.is_playing():
		anim.play("prev")
	else:
		audio.stop("Blip")

func _on_Right_pressed():
	if !anim.is_playing():
		anim.play("next")
	else:
		audio.stop("Blip")

func _on_Start_pressed():
	c.ship = cur
	sc.change_scene("res://Game.tscn", 0.1)
