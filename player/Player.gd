extends Node2D

onready var c = get_node("/root/Constants")
onready var audio = get_node("/root/Audio")

signal health_changed
signal goods_changed
signal crew_changed

var anim

var health = 100 setget set_health
var goods = 1000 setget set_goods
var crew = 10 setget set_crew

var is_dead = false
var is_stranded = false

export var max_goods = 9999
export var max_crew = 10

func _ready():
	var ship
	if c.ship:
		ship = c.ships[c.ship].instance()
	else: 
		ship = c.ships[0].instance()
	anim = ship.get_node("Anim")
	add_child(ship)
	
	for reactor in get_tree().get_nodes_in_group("reactors"):
		reactor.emitting = true


func set_health(new_health):
	if new_health < health:
		anim.play("hurt")
		audio.play("Hurt")
		
	health = new_health
	health = clamp(health, 0, 100)
	
	if health == 0:
		die()
	
	emit_signal("health_changed", health)
	
func set_goods(new_goods):
	goods = new_goods
	goods = clamp(goods, 0, max_goods)
	emit_signal("goods_changed", goods)
	
func set_crew(new_crew):
	crew = new_crew
	crew = clamp(crew, 0, max_crew)
	
	if crew == 0:
		is_stranded = true
	
	emit_signal("crew_changed", crew)

func die():
	is_dead = true
	$Spaceship.visible = false
	$Explosion.emitting = true
	audio.play("Explode")