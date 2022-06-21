extends KinematicBody2D

var exp_amount = 5
onready var player = get_node("/root/Background/Player")
var speed = 1

func _ready():
	pass

func set_red_color():
	$Area2D/Sprite.texture = load("res://assets/map/pickups/pearl_01c.png")


func _on_Area2D_area_entered(area):
	if area.has_method("add_exp"):
		area.add_exp(exp_amount)
		queue_free()
		
func _physics_process(delta):
	var move1 = Vector2.ZERO
	var distance = position.distance_to(player.position)
	
	if(distance<150):
		move1 = position.direction_to(player.position) * speed
		move1 = move1.normalized()
		move1 = move_and_collide(move1)
