extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Score/NewHighScoreLabel").hide()
	get_node("StartButton").connect("button_down", start_game)
	if Global.new_high_score:
		get_node("Score/NewHighScoreLabel").show()
		Global.new_high_score = false
	get_node("Score/ScoreLabel").text = "x %s" % Global.final_score
	get_node("Score/HighScoreLabel").text = "x %s" % Global.high_score


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start_game():
	Global.final_score = 0
	$AudioStreamPlayer2D.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://project/GameManager/game.tscn")
