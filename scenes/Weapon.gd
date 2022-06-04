extends Area2D

export var damage = 10
onready var anim = $AnimationPlayer

func attack():
	anim.play("swing")
	


func _on_Weapon_body_entered(body):
	if body.has_method("handle_hit"):
		body.handle_hit(damage)
