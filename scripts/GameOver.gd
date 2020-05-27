extends Popup

var already_paused
var player

var scene_0 = load("res://scenes/menu.tscn")

func _ready():
	player = get_parent().get_parent().get_node("Player")

func _on_Player_dead():
	if not visible:
		# Pause game
		already_paused = get_tree().paused
		get_tree().paused = true
		# Show popup
		player.set_process_input(false)
		popup()
	var node = scene_0.instance()
	add_child(node)
	get_tree().change_scene("res://scenes/menu.tscn")
	pass # Replace with function body.


func _on_Exit_pressed():

	pass # Replace with function body.
