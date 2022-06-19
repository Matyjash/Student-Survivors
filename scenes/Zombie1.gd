extends KinematicBody2D
var player = null
var speed = 1
onready var animatedSprite = $AnimatedSprite
export var health = 20
export var damage = 10
var oldAnimation = null

func _ready():
	randomize()
	$AnimatedSprite.playing = true
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % (mob_types.size()-1) +1]
	oldAnimation = $AnimatedSprite.animation
	player = get_tree().get_nodes_in_group("player")[0]

func _physics_process(delta):
	var move = Vector2.ZERO
	
	move = position.direction_to(player.position) * speed
	move = move.normalized()
  
	move = move_and_collide(move)
	
func handle_hit(damage):
	health -= damage
	$AnimationPlayer.play("hit")
	if health <= 0:
		get_parent().spawn_exp(position)
		queue_free()

#usuwanie moba po wyjściu z ekranu
func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	animatedSprite.animation = oldAnimation
	animatedSprite.play()
