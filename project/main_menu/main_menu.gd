extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("StartButton").connect("button_down", start_game)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start_game():
	$AudioStreamPlayer2D.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://project/GameManager/game.tscn")
