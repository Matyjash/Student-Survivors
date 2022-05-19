extends RigidBody2D



func _ready():
	randomize()
	$AnimatedSprite.playing = true
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	pass # Replace with function body.

#do poprawy, screen jest niekończony
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
