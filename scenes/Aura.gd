extends Area2D

export var damage = 5
export var unlocked = false
onready var anim = $AnimationPlayer

func attack():
	if unlocked:
		anim.play("Pulse")

func unlock():
	$Sprite.scale.x = 2.35
	$Sprite.scale.y = 2.542
	unlocked = true
	$Sprite.visible = true

func _on_Aura_body_entered(body):
	if unlocked:
		if body.has_method("handle_hit"):
			body.handle_hit(damage)
