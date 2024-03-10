class_name BeltSegment

extends Area2D

var next_segment: BeltSegment = null
var speed: float = 100.0
var item: Item = null
var blocked = false

func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)


func _physics_process(delta):
	if self.has_item() and not blocked:
		if not next_segment or not next_segment.has_item():
			item.move(Global.speed)
		else:
			item.stop()


func set_next_segment(belt: BeltSegment):
	next_segment = belt


func has_item():
	return true if item != null else false


func set_item(new_item):
	item = new_item


func _on_body_entered(body):
	if not has_item():
		item = body


func _on_body_exited(body):
	if not next_segment and item:
		item.stop()
	item = null


func destroy_item():
	if item:
		item.queue_free()
		item = null
