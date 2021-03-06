extends Node2D

var rng = RandomNumberGenerator.new()
var mob_scene = preload("res://scenes/Zombie1.tscn")
var health_scene = preload("res://scenes/Health.tscn")
var damage_up_scene = preload("res://scenes/DamageUp.tscn")
var exp_scene = preload("res://scenes/Exp.tscn")
var speed_up_scene = preload("res://scenes/SpeedUp.tscn")

func _ready():
	randomize()
	new_game()
	$Player/Camera2D/Interface/Bars/LifeBar.set_maximum_value($Player.max_healt_points)
	$Player/Camera2D/Interface/Bars/LifeBar.set_current_value($Player.healt_points)
	pass


func spawn_exp(position, amount, color):
	var exp_point = exp_scene.instance()
	exp_point.position = position
	exp_point.exp_amount = amount
	if color == "red":
		exp_point.set_red_color()
	add_child(exp_point)
	
func update_timer(time):
	var minutes = int(time/60)
	var sec = time - minutes * 60
	
	if minutes < 10:
		if sec < 10:
			$Player/Camera2D/TimeCounter.text = "0"+str(minutes)+":0"+str(sec)
		else:
			$Player/Camera2D/TimeCounter.text = "0"+str(minutes)+":"+str(sec)
	else:
		if sec < 10:
			$Player/Camera2D/TimeCounter.text = str(minutes)+":0"+str(sec)
		else:
			$Player/Camera2D/TimeCounter.text = str(minutes)+":"+str(sec)
	 
	
func _on_Player_hit():
	refresh_Healthbar()

func refresh_Healthbar():
	$Player/Camera2D/Interface/Bars/LifeBar.set_current_value($Player.healt_points)

func refresh_ExperienceBar():
	$Player/Camera2D/Interface/Bars/ExperienceBar.set_current_value($Player.exp_points)
	$Player/Camera2D/Interface/Bars/ExperienceBar.set_maximum_value($Player.next_level_exp)
	
	
func new_game():
	$Player.start()
	$StartTimer.start()

#generowanie pickupa co określoną ilość czasu
func _on_PickupSpawnTimer_timeout():
	var pickup
	var pickup_number = rng.randi_range(0,2)
	if pickup_number == 0:
		pickup = health_scene.instance()
	elif pickup_number == 1:
		pickup = damage_up_scene.instance()
	elif pickup_number == 2:
		pickup = speed_up_scene.instance()
	
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





func _on_Interface_whipUp():
	var old_damage = $Player.whip.damage
	$Player.whip.damage += 5 
	print("whip damage up from ", old_damage, " to ", $Player.whip.damage)

func _on_Interface_swordUp():
	var old_damage = $Player.sword.damage
	$Player.sword.damage += 5 
	print("sword damage up from ", old_damage, " to ", $Player.sword.damage)


func _on_Interface_auraUp():
	var old_damage = $Player.aura.damage
	$Player.aura.damage += 5 
	print("aura damage up from ", old_damage, " to ", $Player.aura.damage)
