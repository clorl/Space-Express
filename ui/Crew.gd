extends Control
onready var tween = $Tween
var cur_crew = 10
onready var Crew_label = $VBoxContainer/CrewCount 
onready var anim = $VBoxContainer/CrewCount/Anim

func update_crew(new_value, a=true):
	if a:
		tween.interpolate_property(self, "cur_crew", cur_crew, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
		if not tween.is_active():
	    tween.start()
		
		if new_value > cur_crew:
			anim.play("gain")
		elif new_value < cur_crew:
			anim.play("lose")
	else:
		cur_crew = new_value


func _ready():
	pass
	
func _process(delta):
	var round_value = round(cur_crew)
	Crew_label.text = str(round_value)


