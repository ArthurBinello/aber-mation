extends Node2D

var play_music = true


# Called when the node enters the scene tree for the first time.
func _ready():
	$Music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if play_music and not $Music.playing:
		$Music.play()


func pause_music():
	play_music = not play_music
	if not play_music:
		$Music.stop()
