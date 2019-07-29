extends KinematicBody2D
var velocity = Vector2()
onready var maxHealth := 3
onready var currentHealth = maxHealth
var dead := false 

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("targetIdle")
	
func enemyTakeDamage(damage : int):
	$AnimationPlayer.play("targetHit")
	currentHealth -= damage
	if(currentHealth <= 0):
		dead = true
		$AnimationPlayer.play("targetBreak")
		
func playerTakeDamage(damage : int):
	return
	