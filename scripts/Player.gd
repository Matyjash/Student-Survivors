extends Area2D

signal hit
export var speed = 300
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	
	
#poruszanie się gracza
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		$AnimatedSprite.set_frame(0)
		
	position += velocity * delta
	#blokowanie wyjścia poza ekran (poki co)
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)




func _on_Player_body_entered(body):
	$AnimatedSprite.flip_v = true 
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
