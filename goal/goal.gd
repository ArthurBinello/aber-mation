extends Area2D

signal increase_score
signal lose_life

@export var incoming: Node2D
var score: int = 0
var lives: int = 3

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
	elif body.item_type == "bad":
		lose_life.emit()
	body.queue_free()
