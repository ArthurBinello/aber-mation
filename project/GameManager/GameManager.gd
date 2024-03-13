extends Node2D

var lives = 3
var score = 0
var speed_increase: float = 1.1

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Goal").connect("increase_score", increase_score)
	get_node("Goal").connect("lose_life", lose_life)
	get_node("Buttons/TextureButton").connect("button_down", get_node("Destroyers/Destroyer").destroy)
	get_node("Buttons/TextureButton2").connect("button_down", get_node("Destroyers/Destroyer2").destroy)
	get_node("Buttons/TextureButton3").connect("button_down", get_node("Destroyers/Destroyer3").destroy)
	get_node("Buttons/TextureButton4").connect("button_down", get_node("Destroyers/Destroyer4").destroy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func increase_score():
	score += 1
	get_node("UserInterface/Score/ScoreLabel").text = "x %s" % score
	if score % 10 == 0:
		Global.speed *= speed_increase


func lose_life():
	lives -= 1
	if lives >= 0:
		get_node("UserInterface/Lives").get_child(lives - 3).modulate = Color(0, 0, 0)
	if lives <= 0:
		await get_tree().create_timer(0.37).timeout
		game_over()


func game_over():
	Global.final_score = score
	if score > Global.high_score:
		Global.high_score = score
		Global.new_high_score = true
	get_tree().change_scene_to_file("res://project/menus/game_over.tscn")
