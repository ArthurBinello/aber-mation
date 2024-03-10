class_name ConveyorBelt

extends Node2D

var segment_scene = preload("res://project/conveyor_belts/belt_segment.tscn")
var segments: Array = []
@export var nb_segments = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in nb_segments:
		var new_segment = segment_scene.instantiate()
		add_segment(new_segment)
		var scale = new_segment.get_node("CollisionShape2D").get_scale()
		var spawn_position = self.position + Vector2(0, (i + 1/scale.y * 2) * new_segment.get_node("CollisionShape2D").get_shape().get_size().y * scale.y)
		new_segment.set_position(spawn_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_segment(segment: BeltSegment):
	segments.append(segment)
	add_child(segment)
	if segments.size() > 1:
		segments[-2].set_next_segment(segments[-1])

func get_spawn_point():
	return self.position + Vector2(0, -self.segments[0].get_node("CollisionShape2D").get_shape().get_size().y*0.75)
