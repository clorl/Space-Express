extends Node2D

export var event_number = 15
var event_index = 1

onready var audio = get_node("/root/Audio")
onready var c = get_node("/root/Constants")

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
	"pirate": preload("res://events/pirate/Pirate.tscn")
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
			execute_event(int(rand_range(1,c.nb_events-2)))
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
	if player.is_dead:
		dead()
		return
	# If game is finished
	if event_index == event_number:
		end()
		return
		
	event_index += 1
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
	player.goods += int(rand_range(50,200))
	audio.play("Cash")
	
	# Player takeoff
	yield(get_tree().create_timer(0.5), "timeout")
	player.anim.play_backwards("land")
	yield(get_tree().create_timer(0.3), "timeout")
	
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
	yield(get_tree().create_timer(0.3), "timeout")
	
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
	yield(get_tree().create_timer(0.3), "timeout")
	
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
	audio.play("Cash")
	player.goods += int(rand_range(50,200))

	# Player takeoff
	yield(get_tree().create_timer(0.5), "timeout")
	player.anim.play_backwards("land")
	yield(get_tree().create_timer(0.3), "timeout")
	
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
	player.get_node("Spaceship/Reactor").emitting = false
	player.anim.stop()
	
	randomize()
	var rand = randi()%7-3
	
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
		player.goods -= int(rand_range(50,100))
		player.crew -= rand
		yield(get_tree().create_timer(0.5), "timeout")
		
		# Get outta here
		pirate.get_node("Sprite/Anim").play("speed_up")
		
	yield(get_tree().create_timer(0.4), "timeout")
	
	# Speed up
	player.get_node("Spaceship/Reactor").emitting = true
	player.anim.play("rumble")
	bg.speed_up(0.5)
	instance.get_node("Sprite/Anim").play("speed_up")

func cloud():
	randomize()
	audio.play("Cough"+String(randi()%3+1))
	player.crew -= randi()%4

func treasure():
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
	audio.play("Mining")
	player.crew -= int(rand_range(0,4))
	if player.is_stranded: return
	
	# Player gets money
	yield(get_tree().create_timer(0.5), "timeout")
	player.goods += int(rand_range(50,300))
	audio.play("Cash")
	
	# Player takeoff
	yield(get_tree().create_timer(0.5), "timeout")
	player.anim.play_backwards("land")
	yield(get_tree().create_timer(0.3), "timeout")
	
	# Speed up
	bg.speed_up(0.5)
	instance.get_node("Sprite/Anim").play("speed_up")

##
# Game end functions
##

func stranded():
	if bg.get_node("Anim").playback_speed == 1:
		bg.slow_down(0.6)
	player.get_node("Spaceship/Reactor").emitting = false
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