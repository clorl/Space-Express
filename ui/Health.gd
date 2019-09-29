extends Control
onready var tween = $Tween
var cur_health = 100
onready var Health_label = $VBoxContainer/HealthCount 
onready var anim = $VBoxContainer/HealthCount/Anim

func update_health(new_value):
	tween.interpolate_property(self, "cur_health", cur_health, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
    tween.start()
	
	if new_value >= cur_health:
		anim.play("gain")
	else:
		anim.play("lose")

func _ready():
	pass#update_health(new_value)
	
func _process(delta):
	var round_value = round(cur_health)
	Health_label.text = str(round_value)


