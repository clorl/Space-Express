extends Control

onready var tween = $Ship/Tween
onready var ship = $Ship
onready var start_point = $Position2D

var sprite = preload("res://ui/event_counter/Point.tscn")

export(int) var evt_number
var distance
var interval
var cur_point = 0

func _ready():
	distance = start_point.position.distance_to($Position2D2.position)
	interval = distance/evt_number
	var pos
	for i in range(evt_number+1):
		pos = Vector2(start_point.position.x+i*interval, start_point.position.y)
		var inst = sprite.instance()
		add_child(inst)
		inst.global_position = pos

func next_point():
	if cur_point == evt_number+1:
		return
	cur_point += 1
	var pos = Vector2(start_point.position.x+cur_point*interval, ship.global_position.y)
	tween.interpolate_property(ship, "global_position", ship.global_position, pos, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()