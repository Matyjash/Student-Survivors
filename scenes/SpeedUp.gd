extends Area2D

const speed_amount = 200
var player

func _ready():
	pass

		
func _on_Timer_timeout():
	player.speed_up(-speed_amount)
	queue_free()


func _on_SpeedUp_area_entered(area):
	if area.has_method("speed_up"):
		player = area
		area.speed_up(speed_amount)
		$Timer.start()
		visible = false
		$CollisionShape2D.disabled = true
