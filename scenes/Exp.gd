extends Area2D

var exp_amount = 5

func _ready():
	pass


func _on_Exp_area_entered(area):
	if area.has_method("add_exp"):
		area.add_exp(exp_amount)
		queue_free()
