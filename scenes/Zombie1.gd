extends KinematicBody2D
var player = null
var speed = 1
func _ready():
	randomize()
	$AnimatedSprite.playing = true
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	player = get_tree().get_nodes_in_group("player")[0]

func _physics_process(delta):
	var move = Vector2.ZERO
	
	move = position.direction_to(player.position) * speed
	move = move.normalized()
	move = move_and_collide(move)
	

#usuwanie moba po wyjściu z ekranu
func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
