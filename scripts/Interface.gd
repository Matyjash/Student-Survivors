extends Control


# Declare member variables here. Examples:
signal swordUp
signal auraUp
signal whipUp


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SwordUpButton_pressed():
	emit_signal("swordUp")
	get_tree().paused = false
	$LevelupButtons.visible = false


func _on_AuraUpButton_pressed():
	emit_signal("auraUp")
	get_tree().paused = false
	$LevelupButtons.visible = false


func _on_WhipUpButton_pressed():
	emit_signal("whipUp")
	get_tree().paused = false
	$LevelupButtons.visible = false


func _on_Player_level_up():
	$LevelupButtons.visible = true
