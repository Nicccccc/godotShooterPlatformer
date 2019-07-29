extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const speed = 1
var target
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	#tells bullet where to go
	target = get_global_mouse_position()
	
	#normalized returns vector scaled to unit length
	velocity = -(position - target).normalized()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#declare and set velocity here for a homing bullet
	#var velocity = Vector2()
	#velocity = -(position - target).normalized
	#velocity = Vector2(30, 0)
	position += velocity/1.3

