extends Area2D

export var damage = 7
export var unlocked = true
onready var anim = $AnimationPlayer

func attack():
	anim.play("swing")
	$SwordAudio.play()
	


func _on_Weapon_body_entered(body):
	if body.has_method("handle_hit"):
		body.handle_hit(damage)
