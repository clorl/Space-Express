extends Node2D

func play(sound):
	var node = get_node(sound)
	assert(node)
	node.play()