extends Node2D

var item_scene = preload("res://items/item.tscn")
var conveyor_scene = preload("res://conveyor_belts/conveyor_belt.tscn")
var conveyor: ConveyorBelt = null
var item_left: String = ""
var item_right: String = ""
var recipes = {
	["A", "B"]: "AB",
	["AB", "C"]: "ABC"
}
var spawn_point: Vector2
@export var left_incoming: Node2D
@export var right_incoming: Node2D
var left_segment: BeltSegment = null
var right_segment: BeltSegment = null

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("EntranceLeft").connect("body_entered", _on_body_entered_left)
	get_node("EntranceRight").connect("body_entered", _on_body_entered_right)

	conveyor = conveyor_scene.instantiate()
	conveyor.nb_segments = 3
	add_child(conveyor)
	var scale = get_node("Sprite2D").get_scale()
	var new_conveyor_belt_start = get_node("Sprite2D").texture.get_width() + conveyor.segments[0].get_node("Sprite2D").texture.get_width() / 2
	conveyor.set_position(Vector2(new_conveyor_belt_start, get_node("Sprite2D").texture.get_height()))
	spawn_point = Vector2(new_conveyor_belt_start, conveyor.segments[0].get_node("Sprite2D").texture.get_height())

	left_segment = left_incoming.get_node("ConveyorBelt").segments[-1]
	right_segment = right_incoming.get_node("ConveyorBelt").segments[-1]
	var left_texture = left_segment.get_node("Sprite2D").texture
	position = left_segment.global_position
	position += Vector2(left_texture.get_width() * scale.x * 1.5, 0) # No idea why I need 1.5
	position += Vector2(0, left_texture.get_height() * scale.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	combine_items()


func _on_body_entered_left(body):
	item_left = body.item_type
	body.queue_free()
	left_segment.blocked = true


func _on_body_entered_right(body):
	item_right = body.item_type
	body.queue_free()
	right_segment.blocked = true


func combine_items():
	if item_left and item_right:
		while not conveyor.segments[0].has_item():
			if [item_left, item_right] in recipes:
				spawn_new_item(recipes[[item_left, item_right]])
			elif [item_right, item_left] in recipes:
				spawn_new_item(recipes[[item_right, item_left]])
			else:
				spawn_new_item("bad")
			item_left = ""
			item_right = ""
			left_segment.blocked = false
			right_segment.blocked = false
			break


func spawn_new_item(type):
	var new_item = item_scene.instantiate()
	call_deferred("add_child", new_item)
	new_item.set_type(type)
	new_item.set_position(spawn_point)
	conveyor.segments[0].set_item(new_item)


func is_left_full():
	return item_left != ""


func is_right_full():
	return item_right != ""
