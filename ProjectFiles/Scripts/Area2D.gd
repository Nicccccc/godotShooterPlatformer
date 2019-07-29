extends Area2D
export var damage := 1

func _on_bulletArea2D_body_entered(body):
	body.enemyTakeDamage(damage)
	get_owner().queue_free()

