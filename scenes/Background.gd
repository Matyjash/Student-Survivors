extends Node2D

var rng = RandomNumberGenerator.new()
var mob_scene = preload("res://scenes/Zombie1.tscn")
var health_scene = preload("res://scenes/Health.tscn")

func _ready():
	randomize()
	new_game()
	$Player/Camera2D/Interface/Bars/LifeBar.set_maximum_value($Player.max_healt_points)
	$Player/Camera2D/Interface/Bars/LifeBar.set_current_value($Player.healt_points)
	pass



func _on_Player_hit():
	refresh_Healthbar()

func refresh_Healthbar():
	print("refreshed healthbar")
	$Player/Camera2D/Interface/Bars/LifeBar.set_current_value($Player.healt_points)

	
func new_game():
	$Player.start()
	$StartTimer.start()

#tworznie nowego moba co okreśolną ilość czasu
func _on_MobSpawnTimer_timeout():
	var mob = mob_scene.instance()
	mob.position = generate_spawn_position()
	add_child(mob)

#generowanie pickupa co określoną ilość czasu
func _on_PickupSpawnTimer_timeout():
	var pickup
	var pickup_number = rng.randi_range(0,2)
	if pickup_number == 0:
		pickup = health_scene.instance()
	elif pickup_number == 1:
		pickup = health_scene.instance() #do zmiany na inny pickup
	elif pickup_number == 2:
		pickup = health_scene.instance() #do zmiany na inny pickup
	
	pickup.position = generate_spawn_position()
	add_child(pickup)
		

func _on_StartTimer_timeout():
	$MobSpawnTimer.start()
	$PickupSpawnTimer.start()

func generate_spawn_position():
	
	var rand_index = randi() % 4
	#losujemy liczbe 1-4 każda odpowiada innej krawędzi ekranu
	#górna część ekranu
	if rand_index == 0:
		var y = $Player.position.y - get_viewport().size.y/2 - 50
		var x1 = $Player.position.x - get_viewport().size.x/2
		var x2 = $Player.position.x + get_viewport().size.x/2
		var x = randi() % int(x2) + x1
		return Vector2(x,y)
	#prawa częśc ekranu
	elif rand_index == 1:
		var x = $Player.position.x + get_viewport().size.x/2 + 50
		var y1 = $Player.position.y - get_viewport().size.y/2
		var y2 = $Player.position.y + get_viewport().size.y/2
		var y = randi() % int(y2) + y1
		return Vector2(x,y)
	#dolna częśc ekranu
	elif rand_index == 2:
		var y = $Player.position.y + get_viewport().size.y/2 + 50
		var x1 = $Player.position.x - get_viewport().size.x/2
		var x2 = $Player.position.x + get_viewport().size.x/2
		var x = randi() % int(x2) + x1
		return Vector2(x,y)
	#lewa część ekranu
	elif rand_index == 3:
		var x = $Player.position.x - get_viewport().size.x/2 - 50
		var y1 = $Player.position.y - get_viewport().size.y/2
		var y2 = $Player.position.y + get_viewport().size.y/2
		var y = randi() % int(y2) + y1
		return Vector2(x,y)
		
	


func _on_Player_die():
	$MobSpawnTimer.stop()



