extends Node2D

onready var player := get_parent()
var maxAmmo := 8
var currentAmmo := maxAmmo

func _ready():
	pass
	
func _physics_process(delta):
	if(currentAmmo == 8):
		$AmmunitionPlayer.play("8shots")
	if(currentAmmo == 7):
		$AmmunitionPlayer.play("7shots")
	if(currentAmmo == 6):
		$AmmunitionPlayer.play("6shots")
	if(currentAmmo == 5):
		$AmmunitionPlayer.play("5shots")
	if(currentAmmo == 4):
		$AmmunitionPlayer.play("4shots")
	if(currentAmmo == 3):
		$AmmunitionPlayer.play("3shots")
	if(currentAmmo == 2):
		$AmmunitionPlayer.play("2shots")
	if(currentAmmo == 1):
		$AmmunitionPlayer.play("1shot")
	if(currentAmmo == 0):
		$AmmunitionPlayer.play("0shots")