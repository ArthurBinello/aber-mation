extends Node2D

var conveyor_scene = preload("res://project/conveyor_belts/conveyor_belt.tscn")               
var item_scene = preload("res://project/items/item.tscn")
var conveyor: ConveyorBelt = null
var spawn_point: Vector2
var bad_item_perc = 10 # percentage of chance to get a bad item
var rng = RandomNumberGenerator.new()
var correct_types = ["A", "B", "C"]
@export var item_type: String
@export var disabled = false
@export var nb_segments = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	if item_type not in correct_types:
		item_type = "A" # default type
	conveyor = conveyor_scene.instantiate()
	conveyor.nb_segments = nb_segments
	add_child(conveyor)
	conveyor.set_position(Vector2(0, self.get_node("Sprite2D").texture.get_height()))
	spawn_point = conveyor.get_spawn_point()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not disabled and not conveyor.segments[0].has_item():
		var new_item = item_scene.instantiate()
		add_child(new_item)
		if randi() % 100 < bad_item_perc:
			new_item.set_type("bad")
		else:
			new_item.set_type(item_type)
		new_item.set_position(spawn_point)
		conveyor.segments[0].set_item(new_item)
