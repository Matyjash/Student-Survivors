extends Area2D

signal hit
signal player_position_changed
export var speed = 300
var screen_size
var count = 0
var background_tiles = null

func _ready():
	screen_size = get_viewport_rect().size
	background_tiles = get_parent().get_node("TileMap")
	
func start():
	show()
	$CollisionShape2D.disabled = false
	
func set_cell(tilemap, x, y, id):
	tilemap.set_cell(x, y, id, false, false, false, get_subtile_with_priority(id, tilemap))
	
func get_subtile_with_priority(id, tilemap: TileMap):
	var tiles = tilemap.tile_set
	var rect = tilemap.tile_set.tile_get_region(id)
	var size_x = rect.size.x / tiles.autotile_get_size(id).x
	var size_y = rect.size.y / tiles.autotile_get_size(id).y
	var tile_array = []
	for x in range (size_x):
		for y in range(size_y):
			var priority = tiles.autotile_get_subtile_priority(id, Vector2(x,y))
			for z in priority:
				tile_array.append(Vector2(x,y))
	return tile_array[randi() % tile_array.size()]
	
func generate_tile_boundary(pos):
	var boundaries = [pos]
	
	for x in 13:
		for y in 8:
			boundaries.append({
				"x": pos.x + x,
				"y": pos.y + y
			})
			boundaries.append({
				"x": pos.x - x,
				"y": pos.y - y
			})
			boundaries.append({
				"x": pos.x + x,
				"y": pos.y - y
			})
			boundaries.append({
				"x": pos.x - x,
				"y": pos.y + y
			})
	return boundaries
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
		emit_signal("player_position_changed")
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		$AnimatedSprite.set_frame(0)
		
	position += velocity * delta
	
	#blokowanie wyjścia poza ekran (poki co)
	#position.x = clamp(position.x, 0, screen_size.x)
	#position.y = clamp(position.y, 0, screen_size.y)
	
	count += 1
	if (count % 15 == 0):
		render_background()
	pass

func render_background():
	var player_pos = background_tiles.world_to_map(self.position)
	var boundaries = generate_tile_boundary(player_pos)
	
	for i in boundaries:
		var tile = background_tiles.get_cell(i.x, i.y)
		var has_tile = tile > -1
		if (!has_tile): set_cell(background_tiles, i.x, i.y, 0)

func _on_Player_body_entered(body):
	$AnimatedSprite.flip_v = true 
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
