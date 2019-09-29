extends Control
onready var tween = $Tween
var cur_goods = 100
onready var Goods_label = $TextureRect/GoodsCount 

func update_goods(new_value):
	tween.interpolate_property(self, "cur_goods", cur_goods, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
    tween.start()

func _ready():
	pass
	
func _process(delta):
	var round_value = round(cur_goods)
	Goods_label.text = str(round_value) + "$"


