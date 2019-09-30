extends Control

var value setget set_value
var max_value setget set_max_val

onready var label = $HBoxContainer/Label
onready var progress = $HBoxContainer/Timer

func set_value(value):
	$HBoxContainer/Label.text = format_time(value)
	$HBoxContainer/Timer.value = value

func set_max_val(value):
	$HBoxContainer/Timer.max_value = value


func format_time(time):
	var sec = int(time)
	var mil = stepify(time - sec, 0.01)
	
	if mil == stepify(mil, 0.1):
		mil = String(mil) + "0"
	mil = String(mil)
	mil = mil.substr(2,mil.length())
	
	return String(sec) + ":" + String(mil)