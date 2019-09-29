extends Control
onready var tween = $Tween
var score = 0
onready var score_label = $VBox/HBox/Score
onready var appreciation = $VBox/Appreciation

func set_score(new_value):
	tween.interpolate_property(self, "score", score, new_value, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
    tween.start()
	
	var color
	
	if new_value == 0:
		appreciation.text = "Your client didn't even pay you. All the merchandise got lost ? What a scam ! You're the worst !"
		color = Color(1,0,0)
	if new_value < 500 && new_value != 0:
		appreciation.text = "Your client is really upset ! How can so much of the merchandise be gone ?!"
		color = Color(1,0,0)
	if new_value >= 500 && new_value <1000:
		appreciation.text = "Some of the merchandise is missing. Anyway, I guess it'll work ? Do better next time."
		color = Color(1,1,0)
	if new_value >= 1000 && new_value < 1200:
		appreciation.text = "Your client is satisfied, everything is here, and the delivery was really fast ! He gave you a good rating on Space-Amazon."
	if new_value >= 1200 && new_value <3000:
		appreciation.text = "Your client is satisfied, and you even earned a bit of money on the way !"
	if new_value >= 3000:
		appreciation.text = "You earned so much money during this trip that you stopped working as a cargo altogether !"
	if new_value >= 50000:
		appreciation.text = "What are you, a cheater ?"
	if !color: color = Color(0,1,0)
	
	$Tween.interpolate_property($VBox/HBox, "modulate", Color(1,1,1), color, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func _ready():
	pass
	
func _process(delta):
	var round_value = round(score)
	score_label.text = str(round_value)
