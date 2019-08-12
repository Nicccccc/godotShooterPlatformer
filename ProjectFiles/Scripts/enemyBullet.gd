extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const speed = 1
var target
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.self_modulate = Color(1,0,0)
	velocity = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity/2.2
