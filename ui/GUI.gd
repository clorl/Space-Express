extends Control
onready var Goods = $Goods
onready var Health = $Health
onready var Crew = $Crew

func _on_Player_goods_changed(new_goods):
	Goods.cur_goods = new_goods

func _on_Player_health_changed(new_health):
	Health.cur_health = new_health
	
func _on_Player_crew_changed(new_crew):
	Crew.cur_crew = new_crew
	
func _ready():
	pass


