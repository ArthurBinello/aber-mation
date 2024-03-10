class_name Item

extends RigidBody2D

var textures = {
	"A": preload("res://items/item_A.png"),
	"B": preload("res://items/item_B.png"),
	"C": preload("res://items/item_C.png"),
	"AB": preload("res://items/item_AB.png"),
	"ABC": preload("res://items/item_ABC.png"),
	"bad": preload("res://items/item_bad.png")
}
var item_type: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#self.scale = Vector2(1, 1)
	pass


func move(speed):
	var velocity = speed * Vector2.DOWN
	set_linear_velocity(velocity)


func stop():
	var velocity = Vector2(0, 0)
	set_linear_velocity(velocity)


func set_type(type):
	item_type = type
	get_node("Sprite2D").set_texture(textures[item_type])
