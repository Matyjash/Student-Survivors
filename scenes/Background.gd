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
	$MobPath.position.x = $Player.position.x - 300
	$MobPath.position.y = $Player.position.y + 200
	$MobPath/MobSpawnLocation.position = $MobPath.position
	
	var mob = mob_scene.instance()
	
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()
	
	var direction = mob_spawn_location.rotation + PI /2
	
	mob.position = mob_spawn_location.position
	direction += rand_range(-PI /4 , PI/4)
	mob.rotation = direction
	
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)


func _on_StartTimer_timeout():
	$MobSpawnTimer.start()
	

func _on_Player_player_position_changed():
	print($MobPath.position)
	
