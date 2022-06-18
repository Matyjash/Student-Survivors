extends Area2D

const health_amount = 10

func _ready():
	pass

func _on_Health_area_entered(area):
	if area.has_method("heal"):
		area.heal(health_amount)
		queue_free()
