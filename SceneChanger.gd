extends CanvasLayer

signal scene_changed

onready var animation_player = $Anim
onready var black = $ColorRect

func _ready():
	pass

func change_scene(path, delay = 1):
	yield(get_tree().create_timer(delay), "timeout")
	animation_player.play("fade")
	yield(animation_player, "animation_finished")
	get_tree().change_scene(path)
	animation_player.play_backwards("fade")
	yield(animation_player, "animation_finished")
	emit_signal("scene_changed")

func quit(delay = 0.1):
	yield(get_tree().create_timer(delay), "timeout")
	animation_player.play("fade")
	yield(animation_player, "animation_finished")
	get_tree().quit()