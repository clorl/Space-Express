extends Control
onready var tween = $Tween
onready var Goods_label = $TextureRect/GoodsCount 
onready var anim = $TextureRect/GoodsCount/Anim
var cur_goods = 100


func update_goods(new_value, a=true):
	if a:
		tween.interpolate_property(self, "cur_goods", cur_goods, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
		if not tween.is_active():
	    tween.start()
		
		if new_value > cur_goods:
			anim.play("gain")
		elif new_value < cur_goods:
			anim.play("lose")
	else:
		cur_goods = new_value
	


func _ready():
	pass
	
func _process(delta):
	var round_value = round(cur_goods)
	Goods_label.text = str(round_value) + "$"


