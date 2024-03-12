extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Buttons/StartButton").connect("button_down", start_game)
	get_node("Buttons/HowToButton").connect("button_down", how_to)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start_game():
	$AudioStreamPlayer2D.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://project/GameManager/game.tscn")


func how_to():
	$AudioStreamPlayer2D.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://project/menus/how_to_play.tscn")
