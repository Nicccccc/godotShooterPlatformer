extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Mouse_Position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Mouse_Position = get_local_mouse_position()
	rotation += Mouse_Position.angle()
