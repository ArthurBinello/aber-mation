extends Area2D

signal increase_score
signal lose_life

@export var incoming: Node2D
var score: int = 0
var lives: int = 3
var goal_sound = load("res://project/audio/goal.wav")
var explosion_sound = load("res://project/audio/explosion.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _on_body_entered)
	position = incoming.get_node("ConveyorBelt").segments[-1].global_position
	position += Vector2(0, incoming.get_node("Sprite2D").texture.get_height() * 3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.item_type == "ABC":
		increase_score.emit()
		$AudioStreamPlayer2D.stream = goal_sound
		$AudioStreamPlayer2D.play()
	elif body.item_type == "bad":
		$AudioStreamPlayer2D.stream = explosion_sound
		$AudioStreamPlayer2D.play()
		lose_life.emit()
	body.queue_free()
