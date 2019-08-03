extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Mouse_Position
var Real_Mouse_Position
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Mouse_Position = get_local_mouse_position()
	Real_Mouse_Position = global_position.angle_to_point(get_global_mouse_position())
	rotation += Mouse_Position.angle()

	if(Real_Mouse_Position < PI/2 && Real_Mouse_Position > -PI/2):
		$gunSprite.flip_v = true
	else:
		$gunSprite.flip_v = false

