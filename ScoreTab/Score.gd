extends Control
onready var tween = $Tween
var cur_score = 0
onready var Score_label = $ScoreCount
signal scene_changed

func update_score(new_value):
	tween.interpolate_property(self, "cur_score", cur_score, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
    tween.start()

func _ready():
	pass#update_health(new_value)
	
func _process(delta):
	var round_value = round(cur_score)
	Score_label.text = str(round_value)
	if(cur_score == 0):
		$Popup.popup()
	
func change_scene(path, delay = 0.5):
	yield(get_tree().create_timer(delay), "timeout")
	assert(get_tree().change_scene(path) == OK)

func _on_Play_pressed():
	change_scene("res://Game.tscn")
	


func _on_Menu_pressed():
	change_scene("res://Menu/Menu.tscn")
