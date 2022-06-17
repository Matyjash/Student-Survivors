extends Area2D

export var damage = 5
export var unlocked = false
onready var anim = $AnimationPlayer

func attack():
	if unlocked:
		anim.play("Pulse")

func unlock():
	unlocked = true
	$Sprite.visible = true

func _on_Aura_body_entered(body):
	if unlocked:
		if body.has_method("handle_hit"):
			body.handle_hit(damage)
