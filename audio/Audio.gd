extends Node2D

func play(sound):
	var node = get_node(sound)
	assert(node)
	node.pitch_scale = 1
	node.play()

func stop(sound):
	var node = get_node(sound)
	assert(node)
	node.stop()

func play_pitch(sound, pitch):
	var node = get_node(sound)
	assert(node)
	node.pitch_scale = pitch
	node.play()