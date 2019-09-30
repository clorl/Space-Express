extends Node2D

enum {
	unknown
	asteroids
	cantina
	pirate
	contraband
	repair
	graveyard
	sos
	cloud
	treasure
	nothing
	}

var firs_time = true

var nb_events = 11
var ship

var ships = [
preload("res://player/ships/Basic.tscn"),
preload("res://player/ships/Titine.tscn"),
preload("res://player/ships/Fauche.tscn"),
preload("res://player/ships/Kyle.tscn"),
preload("res://player/ships/Futurama.tscn")
]

var ships_images = [
preload("res://player/spaceship.png"),
preload("res://player/ships/titine.png"),
preload("res://player/ships/fauche.png"),
preload("res://player/ships/kyle.png"),
preload("res://player/ships/futurama.png")
]

var ships_descs = [
"The most basic ship. If you're the vanilla kind.",
"This is the big deal. This ship is a BEAST. Might make you look like a redneck though.",
"This ship looks very techy. Like, into the future of the future \"techy\"",
"Grab a can of Monster (#NotSponsored) and GET IN DA SHIP",
"This is totally not a very similar ship to an animated TV show."
]