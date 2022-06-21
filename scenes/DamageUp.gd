extends Area2D

const damage_bonus = 30
var player

func _ready():
	pass

func _on_DamageUp_area_entered(area):
	if area.has_method("damage_up"):
		player = area
		player.damage_up(damage_bonus)
		visible = false
		$CollisionShape2D.disabled = true
		$Timer.start()
		


func _on_Timer_timeout():
	player.damage_up(-damage_bonus)
	queue_free()
