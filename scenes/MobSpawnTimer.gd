extends Timer

var game_time = 0
var wave = 0
var mob_scene = preload("res://scenes/Zombie1.tscn")

func _ready():
	pass


func _on_MobSpawnTimer_timeout():
	game_time += 1
	get_parent().update_timer(game_time)
	if game_time % 30 == 0:
		print("new wave")
		wave +=1
		generate_new_wave()
	elif game_time % 2 == 0:
		spawn_mob()
	
	
func generate_new_wave():
	generate_new_boss()
	for i in range (10 + wave):
		spawn_mob()
	
	
func generate_new_boss():
	var mob = mob_scene.instance()
	mob.health = (20 + wave * 5) * 3
	mob.scale = mob.scale * 2
	mob.exp_to_drop = (5 + wave) * 4 
	mob.type = "boss"
	mob.position = get_parent().generate_spawn_position()
	get_parent().add_child(mob)

func spawn_mob():
	var mob = mob_scene.instance()
	mob.health = 20 + wave * 5
	mob.position = get_parent().generate_spawn_position()
	mob.exp_to_drop = 5 + wave 
	get_parent().add_child(mob)
	
	
	
