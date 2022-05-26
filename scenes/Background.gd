extends Node2D

export(PackedScene) var mob_scene

func _ready():
	randomize()
	new_game()
	pass



func _on_Player_hit():
	$MobSpawnTimer.stop()
	
func new_game():
	$Player.start()
	$StartTimer.start()

#tworznie nowego moba co okreśolną ilość czasu
func _on_MobSpawnTimer_timeout():
	
	
	var mob = mob_scene.instance()
	mob.position = generate_spawn_position()
	
	
	add_child(mob)


func _on_StartTimer_timeout():
	$MobSpawnTimer.start()

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
		
	
