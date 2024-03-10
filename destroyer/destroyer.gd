extends Node2D

var segment: BeltSegment
@export var conveyor: Node2D
@export var texture_name: String

# Called when the node enters the scene tree for the first time.
func _ready():
	segment = conveyor.get_node("ConveyorBelt").segments[-2]
	position = segment.global_position
	position -= Vector2(segment.get_node("Sprite2D").texture.get_width() * 3, 0)
	if texture_name != "":
		get_node("Sprite2D").texture = load("res://destroyer/destroyer_%s.png" % texture_name)
	$DestroyAnimation.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func destroy():
	$DestroyAnimation.show()
	$DestroyAnimation.frame = 0
	segment.destroy_item()
	await get_tree().create_timer(0.6).timeout
	$DestroyAnimation.hide()


func _on_button_button_down():
	destroy()
