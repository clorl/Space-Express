extends TextureRect

func slow_down(time):
	$Tween.interpolate_property($Anim, "Anim:speed", 1, 0, time, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	if !$Tween.is_active():
		$Tween.start()

func speed_up(time):
	$Tween.interpolate_property($Anim, "Anim:speed", 0, 1, time, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	if !$Tween.is_active():
		$Tween.start()