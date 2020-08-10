extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var scene_0 = load("res://scenes/choose_save.tscn")
var scene_1 = load("res://scenes/settings.tscn")
var scene_2 = load("res://scenes/credits.tscn")
var scene_3 = load("res://scenes/game.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_TextureButton_pressed():
	var node = scene_0.instance()
	add_child(node)
	get_tree().change_scene("res://scenes/choose_save.tscn")
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_TextureButton_1_pressed():
	var node = scene_1.instance()
	add_child(node)
	get_tree().change_scene("res://scenes/settings.tscn")
	pass # Replace with function body.



func _on_TextureButton_2_pressed():
	var node = scene_2.instance()
	add_child(node)
	get_tree().change_scene("res://scenes/credits.tscn")
	pass # Replace with function body.


func _on_save_1_pressed():
	var node = scene_3.instance()
	add_child(node)
	get_tree().change_scene("res://scenes/game.tscn")
	pass # Replace with function body.

