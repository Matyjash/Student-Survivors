extends KinematicBody2D
var player = null
var speed = 1
onready var animatedSprite = $AnimatedSprite
export var health = 20
export var damage = 10
var type = "mob"
var exp_to_drop = 3
var oldAnimation = null

func _ready():
	randomize()
	$AnimatedSprite.playing = true
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	mob_types.remove("boss")
	mob_types.remove("boss_hit")
	mob_types.remove("hit")
	$AnimatedSprite.animation = mob_types[randi() % (mob_types.size())]
	oldAnimation = $AnimatedSprite.animation
	player = get_tree().get_nodes_in_group("player")[0]
	if type == "boss":
		$AnimatedSprite.animation = "boss"
		oldAnimation = $AnimatedSprite.animation


func _physics_process(delta):
	var move1 = Vector2.ZERO
	
	move1 = position.direction_to(player.position) * speed
	move1 = move1.normalized()
	
	if move1.x < 0:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
		
  
	move1 = move_and_collide(move1)
	
func handle_hit(damage):
	health -= damage
	if type == "boss":
		$AnimationPlayer.play("hit_boss")
	else:
		$AnimationPlayer.play("hit")
	$Cut.play()
	if health <= 0:
		visible = false
		if type == "boss":
			get_parent().spawn_exp(position, exp_to_drop, "red")
		else:
			get_parent().spawn_exp(position, exp_to_drop, "blue")
		queue_free()

#usuwanie moba po wyjściu z ekranu
func _on_VisibilityNotifier2D_viewport_exited(viewport):
	if type != "boss":
		queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	animatedSprite.animation = oldAnimation
	animatedSprite.play()
