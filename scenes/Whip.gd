extends Area2D

export var damage = 50
export var unlocked = true
onready var anim = $AnimationPlayer

func attack():
	if unlocked:
		$WhipAudio.play()
		anim.play("whip")

func unlock():
	unlocked = true
	$Sprite.visible = true
func _on_Whip_body_entered(body):
	if unlocked:
		if body.has_method("handle_hit"):
			body.handle_hit(damage)
