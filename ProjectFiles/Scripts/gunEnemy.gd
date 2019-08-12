extends KinematicBody2D
var velocity = Vector2()
onready var maxHealth := 1
onready var currentHealth = maxHealth
export (float) var runSpeed = 80
export(float) var jumpHeight = 40
export(float) var jumpTime = 0.3
var spriteFacingRight = true
var dead := false 

onready var player:= get_node("../Player")  

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.self_modulate = Color(1,0,0)
	
func enemyTakeDamage(damage : int):
	currentHealth -= damage
	if(currentHealth <= 0):
		dead = true
		queue_free()
		
func playerTakeDamage(damage : int):
	return
	
func _physics_process(delta):
	var move = 0.0
	var gravity = 2*jumpHeight/(jumpTime*jumpTime)
	
	if(dead):
		queue_free()
	
	if(velocity.x == 0):
		$AnimationPlayer.play("gunEnemyIdle")
	
#	if(position.x < player.position.x):
#		move += 1
#		if(velocity.x > 0):
#			$Sprite.flip_h = false
#		$AnimationPlayer.play("gunEnemyRun")
#
#	if(position.x > player.position.x):
#		move -= 1
#		if(velocity.x < 0):
#			spriteFacingRight = false
#		else:
#			spriteFacingRight = true
#		if(!spriteFacingRight):
#			$Sprite.flip_h = true
#		$AnimationPlayer.play("gunEnemyRun")

	else:
		move = 0

	velocity.x = move * runSpeed
	velocity.y += gravity*delta
	# -y is up, +y is down
	velocity = move_and_slide(velocity, Vector2(0, -1))

func shoot():
	var shot = load("res://Scenes/enemyBullet.tscn").instance()
	shot.position = get_global_position()
	get_parent().add_child(shot)
	
#func _on_AnimationPlayer_animation_finished(anim_name):
#		if(abs(position.x - player.position.x) > skeletonAttackDistance):
#			skeletonAttack = false
