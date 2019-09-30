extends Node2D

export var event_number = 15
var event_index = 1

onready var audio = get_node("/root/Audio")
onready var c = get_node("/root/Constants")

onready var evt_counter = $HUD/GUI/EventCounter
onready var game_over = $HUD/GameOver
onready var cam_anim = $Background/Camera2D/CamAnim
onready var overlay_anim = $Warning/Anim
onready var bg = $Background/Camera2D/BG

onready var gui = $HUD/GUI
onready var choices = $Choice/Choices
onready var player = $Player

const nodes = {
	"asteroids": preload("res://events/asteroids/Asteroids.tscn"),
	"contraband": preload("res://events/contraband/Contraband.tscn"),
	"cantina": preload("res://events/cantina/Cantina.tscn"),
	"repair": preload("res://events/repair/Repair.tscn"),
	"pirate": preload("res://events/pirate/Pirate.tscn"),
	"cloud": preload("res://events/cloud/Cloud.tscn"),
	"graveyard": preload("res://events/graveyard/Graveyard.tscn"),
	"treasure": preload("res://events/treasure/Treasure.tscn")
	}

func _ready():
	# Init stuff
	randomize()
	audio.play("GameMusic")
	init_gui()
	
	# Start game
	yield(get_tree().create_timer(2), "timeout")
	choices.propose_choices(player.crew)
	overlay_anim.play("warning")

# Function that manages which function to call
func execute_event(e):
	match e:
		c.unknown:
			randomize()
			execute_event(int(rand_range(1,c.nb_events-1)))
		c.asteroids:
			asteroids()
		c.cantina:
			cantina()
		c.pirate:
			pirate()
		c.contraband:
			contraband()
		c.repair:
			repair()
		c.graveyard:
			graveyard()
		c.sos:
			sos()
		c.cloud:
			cloud()
		c.treasure:
			treasure()
		c.nothing:
			pass
		_:
			pass
	yield(get_tree().create_timer(2), "timeout")
	
	# if player dead or stranded
	if player.is_stranded:
		stranded()
		return
	elif player.is_dead:
		dead()
		return
	# If game is finished
	elif event_index == event_number:
		end()
		return
	else:
		event_index += 1
		evt_counter.next_point()
		choices.propose_choices(player.crew)

##
# Event functions
##

func asteroids():
	# Add asteroids
	var instance = nodes.asteroids.instance()
	instance.global_position = Vector2(0,0)
	add_child(instance)
	
	# Wait a bit and animate
	yield(get_tree().create_timer(0.5), "timeout")
	player.health -= int(rand_range(5,50))
	cam_anim.play("screenshake")
	
	yield(get_tree().create_timer(3), "timeout")
	instance.queue_free()

func contraband():
	# Add instance
	var instance = nodes.contraband.instance()
	instance.global_position = Vector2(0,0)
	instance.z_index = -1
	add_child(instance)
	
	# Slow down
	bg.slow_down(0.6)
	yield(get_tree().create_timer(0.6), "timeout")
	
	# Land
	player.anim.play("land")
	yield(get_tree().create_timer(0.4), "timeout")
	
	# Player gets repaired
	audio.play("Repair")
	player.health -= int(rand_range(5,30))
	if player.is_dead: return
	
	# Player gets money
	yield(get_tree().create_timer(0.5), "timeout")
	player.goods += int(rand_range(0,100))
	audio.play("Cash")
	
	# Player takeoff
	yield(get_tree().create_timer(0.5), "timeout")
	player.anim.play_backwards("land")
	yield(player.anim, "animation_finished")
	player.anim.play("rumble")
	
	# Speed up
	bg.speed_up(0.5)
	instance.get_node("Sprite/Anim").play("speed_up")

func cantina():
	# Add instance
	var instance = nodes.cantina.instance()
	instance.global_position = Vector2(0,0)
	instance.z_index = -1
	add_child(instance)
	
	# Slow down
	bg.slow_down(0.6)
	yield(get_tree().create_timer(0.6), "timeout")
	
	# Land
	player.anim.play("land")
	yield(get_tree().create_timer(0.4), "timeout")
	
	if player.goods > 0:
		audio.play_pitch("Cash", 0.5)
		player.goods -= int(rand_range(50,500))
		player.crew += int(rand_range(0,4))
		yield(get_tree().create_timer(0.5), "timeout")
	
	# Player takeoff
	player.anim.play_backwards("land")
	yield(player.anim, "animation_finished")
	player.anim.play("rumble")
	
	# Speed up
	bg.speed_up(0.5)
	instance.get_node("Sprite/Anim").play("speed_up")

func repair():
	# Add instance
	var instance = nodes.repair.instance()
	instance.global_position = Vector2(0,0)
	instance.z_index = -1
	add_child(instance)
	
	# Slow down
	bg.slow_down(0.6)
	yield(get_tree().create_timer(0.6), "timeout")
	
	# Land
	player.anim.play("land")
	yield(get_tree().create_timer(0.4), "timeout")
	player.anim.play("rumble")
	
	if player.goods > 0 && player.health < 100:
		# Repair
		player.health += int(rand_range(5,20))
		audio.play("Repair")
		audio.play("Select")
		
		# Pay
		yield(get_tree().create_timer(0.5), "timeout")
		audio.play("Cash")
		player.goods -= int(rand_range(50,700))
		yield(get_tree().create_timer(0.5), "timeout")
	
	# Player takeoff
	player.anim.play_backwards("land")
	yield(player.anim, "animation_finished")
	player.anim.play("rumble")
	
	# Speed up
	bg.speed_up(0.5)
	instance.get_node("Sprite/Anim").play("speed_up")

func pirate():
	# Add instance
	var instance = nodes.pirate.instance()
	instance.global_position = Vector2(0,0)
	instance.z_index = -1
	add_child(instance)
	
	# Slow down
	yield(get_tree().create_timer(0.6), "timeout")
	
	# Land
	yield(get_tree().create_timer(0.4), "timeout")
	
	# Get pirated
	audio.play("Pirate")
	player.anim.play("hurt")
	randomize()
	player.goods -= int(rand_range(50,500))
	player.crew -= int(rand_range(0,4))
	yield(get_tree().create_timer(0.5), "timeout")
	
	# Get outta here
	instance.get_node("Sprite/Anim").play("speed_up")

func graveyard():
	# Add instance
	var instance = nodes.graveyard.instance()
	instance.global_position = Vector2(0,0)
	instance.z_index = -1
	add_child(instance)
	
	# Slow down
	bg.slow_down(0.6)
	yield(get_tree().create_timer(0.6), "timeout")
	
	# Land
	player.anim.play("land")
	yield(get_tree().create_timer(0.4), "timeout")
	
	# Player gets money
	audio.play("Cash")
	player.goods += int(rand_range(0,100))

	# Player takeoff
	yield(get_tree().create_timer(0.5), "timeout")
	player.anim.play_backwards("land")
	yield(player.anim, "animation_finished")
	player.anim.play("rumble")
	
	# Speed up
	bg.speed_up(0.5)
	instance.get_node("Sprite/Anim").play("speed_up")

func sos():
	# Add instance
	var instance = nodes.repair.instance()
	instance.global_position = Vector2(0,0)
	instance.z_index = -1
	add_child(instance)
	
	# Slow down
	bg.slow_down(0.6)
	yield(get_tree().create_timer(0.6), "timeout")
	for reactor in get_tree().get_nodes_in_group("reactors"):
		reactor.emitting = false
	player.anim.stop()
	
	randomize()
	var rand = int(rand_range(-1,0))
	
	if rand >= 0:
		player.crew += rand
		audio.play("Select")
	else:
		# Add pirate
		var pirate = nodes.pirate.instance()
		pirate.global_position = Vector2(0,0)
		pirate.z_index = -1
		add_child(pirate)
		
		# Slow down
		yield(get_tree().create_timer(0.6), "timeout")
		
		# Get pirated
		audio.play("Pirate")
		player.anim.play("hurt")
		randomize()
		player.goods -= int(rand_range(50,300))
		player.crew -= int(rand_range(3,5))
		yield(get_tree().create_timer(0.5), "timeout")
		
		# Get outta here
		pirate.get_node("Sprite/Anim").play("speed_up")
		
	yield(get_tree().create_timer(0.4), "timeout")
	
	# Speed up
	for reactor in get_tree().get_nodes_in_group("reactors"):
		reactor.emitting = true
	player.anim.play("rumble")
	bg.speed_up(0.5)
	instance.get_node("Sprite/Anim").play("speed_up")

func cloud():
	# Add asteroids
	var instance = nodes.cloud.instance()
	instance.global_position = Vector2(0,0)
	add_child(instance)
	
	yield(get_tree().create_timer(0.5), "timeout")
	randomize()
	audio.play("Cough"+String(randi()%3+1))
	player.crew -= randi()%3+1
	
	yield(get_tree().create_timer(3), "timeout")
	instance.queue_free()

func treasure():
	# Add instance
	var instance = nodes.treasure.instance()
	instance.global_position = Vector2(0,0)
	instance.z_index = -1
	add_child(instance)
	
	# Slow down
	bg.slow_down(0.6)
	yield(get_tree().create_timer(0.6), "timeout")
	
	# Land
	player.anim.play("land")
	yield(get_tree().create_timer(0.4), "timeout")
	
	# Player loses crew
	audio.play("Mining")
	player.crew -= int(rand_range(1,4))
	if player.is_stranded: return
	
	# Player gets money
	yield(get_tree().create_timer(0.5), "timeout")
	player.goods += int(rand_range(0,150))
	audio.play("Cash")
	
	# Player takeoff
	yield(get_tree().create_timer(0.5), "timeout")
	player.anim.play_backwards("land")
	yield(player.anim, "animation_finished")
	player.anim.play("rumble")
	
	# Speed up
	bg.speed_up(0.5)
	instance.get_node("Sprite/Anim").play("speed_up")

##
# Game end functions
##

func stranded():
	if bg.get_node("Anim").playback_speed == 1:
		bg.slow_down(0.6)
	for reactor in get_tree().get_nodes_in_group("reactors"):
		reactor.emitting = false
	player.anim.stop()
	yield(get_tree().create_timer(1), "timeout")
	game_over.get_node("Text").text = "YOU HAVE LOST ALL YOUR CREW.\n\nYOUR SHIP IS STRANDED IN DEEP SPACE"
	game_over.popup()
	game_over.get_node("AnimationPlayer").play("fade_in")

func dead():
	game_over.get_node("Text").text = "YOUR SHIP WAS TOO DAMAGED, \n\nIT WAS DESTROYED. GET REKT."
	game_over.popup()
	game_over.get_node("AnimationPlayer").play("fade_in")

func end():
	var score = $HUD/Score 
	score.popup()
	score.get_node("Anim").play("fade")
	score.get_node("Score").set_score(player.goods)

##
# Other functions
##

# Init HUD
func init_gui():
	gui._on_Player_goods_changed(player.goods, false)
	gui._on_Player_crew_changed(player.crew, false)
	gui._on_Player_health_changed(player.health, false)

# When choice has been made
func _on_Choices_event_selected(event):
	execute_event(event)