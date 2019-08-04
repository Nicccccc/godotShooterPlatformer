extends KinematicBody2D

export(float) var runSpeed = 220

var velocity = Vector2()
export(float) var jumpHeight = 40
export(float) var jumpTime = 0.3
export(bool) var canIdle = true
#canFall is the ability to play the falling animation
export(bool) var canFall = true
var value
var maxHealth = 3
var currentHealth = maxHealth
#stores the hitBox direction so it can be flipped when player changes direction
var hitBoxFacesRight = true
var dead := false
var reloadTime = 120
var currentReloadTime

func _ready():
	$AnimationPlayer.play("playerIdle")
	currentReloadTime = reloadTime

func playerTakeDamage(damage : int):
	if(!dead):
		value = get_node("HealthBar").get_value()
		get_node("HealthBar").set_value(value - damage)
		currentHealth -= damage
		if(currentHealth <= 0 ):
			dead = true
			$AnimationPlayer.play("playerDeath")
	else:
		return
		
func reload():
	get_node("basicAmmoCounter/AmmunitionPlayer").play("reload")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var move = 0.0
	var gravity = 2*jumpHeight/(jumpTime*jumpTime)
			
	if(dead):
		return
	
	#movement
	if(Input.is_action_pressed("ui_right")):
		move += 1
		if(velocity.x > 0):
			$Sprite.flip_h= false
			if(!hitBoxFacesRight):
				#flips the player hitbox
				$playerHitbox/CollisionShape2D.position.x *= -1
				hitBoxFacesRight = true
		if(velocity.x < 0):
			$Sprite.flip_h= true
			if(hitBoxFacesRight):
				#flips the player hitbox
				$playerHitbox/CollisionShape2D.position.x *= -1
				hitBoxFacesRight = false
		if(canFall):
			$AnimationPlayer.play("playerRun")
	
	elif(Input.is_action_pressed("ui_left")):
		move -= 1
		if(velocity.x < 0):
			$Sprite.flip_h= true
			if(hitBoxFacesRight):
				#flips the player hitbox
				$playerHitbox/CollisionShape2D.position.x *= -1
				hitBoxFacesRight = false
		if(canFall):
			$AnimationPlayer.play("playerRun")
	else:
		velocity.x = 0
		if(canIdle):
			$AnimationPlayer.play("playerIdle")
		
	if(Input.is_action_just_pressed("jump") && is_on_floor()):
		$AnimationPlayer.play("playerJump")
		velocity.y = -2*jumpHeight/jumpTime

	#attacks
	if(Input.is_action_just_pressed("fire") && get_node("basicAmmoCounter").currentAmmo > 0):
#		canFall = false
#		canIdle = false
		var shot = load("res://Scenes/basicBullet.tscn").instance()
		shot.position = get_global_position()
		get_parent().add_child(shot)
		#updates ammunition variable in the counter node so the sprite can update, get_node needs to be used here not a proxy variable
		get_node("basicAmmoCounter").currentAmmo -= 1

	#auto reload
	if(get_node("basicAmmoCounter").currentAmmo == 0 && currentReloadTime > 0):
		currentReloadTime -= 1
	if(get_node("basicAmmoCounter").currentAmmo <= 0 && currentReloadTime <= 0):
		get_node("basicAmmoCounter").fillAmmo()
		currentReloadTime = reloadTime

	#manual reload
	if(Input.is_action_just_pressed("reload")):
		get_node("basicAmmoCounter").currentAmmo = 0

	#movement calculations
	# -y is up, +y is down
	velocity.y += gravity*delta
	velocity.x = move * runSpeed
	velocity = move_and_slide(velocity, Vector2(0, -1))

