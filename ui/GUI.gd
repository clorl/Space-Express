extends Control
onready var Goods = $Goods
onready var Health = $Health
onready var Crew = $Crew

func _on_Player_goods_changed(new_goods, anim=true):
	Goods.update_goods(new_goods, anim)

func _on_Player_health_changed(new_health, anim=true):
	Health.update_health(new_health, anim)
	
func _on_Player_crew_changed(new_crew, anim=true):
	Crew.update_crew(new_crew, anim)


