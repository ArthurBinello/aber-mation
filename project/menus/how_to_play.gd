extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("TextureButton").connect("button_down", main_menu)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func main_menu():
	$AudioStreamPlayer2D.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://project/menus/main_menu.tscn")
