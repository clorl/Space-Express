extends CenterContainer

var value setget set_value
var max_value setget set_max_val

onready var tween = $Tween
onready var label = $HBoxContainer/Label
onready var progress = $HBoxContainer/Timer

func set_value(value):
	$HBoxContainer/Label.text = String(value)
	$HBoxContainer/Timer.value = value

func set_max_val(value):
	$HBoxContainer/Timer.max_value = value