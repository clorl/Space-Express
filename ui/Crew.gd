extends Control
onready var tween = $Tween
var cur_crew = 100 setget update_crew
onready var Crew_label = $CrewCount 

func update_crew(new_value):
	tween.interpolate_property(self, "cur_crew", cur_crew, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
    tween.start()

func _ready():
	pass
	
func _process(delta):
	var round_value = round(cur_crew)
	Crew_label.text = str(round_value)


