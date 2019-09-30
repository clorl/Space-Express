extends Control

signal popup_hidden



func _on_Cancel_pressed():
	emit_signal("popup_hidden")
