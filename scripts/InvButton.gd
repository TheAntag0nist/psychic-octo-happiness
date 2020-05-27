extends TextureButton

var scene_0 = preload("res://scenes/Inventory.tscn")
var visible_bool

func _ready():
	visible_bool = false
	pass 

func _on_InvButton_pressed():
	if visible_bool == false:
		get_node("Inventory").show()
		visible_bool = true
	elif visible_bool == true:
		$Inventory.hide()
		visible_bool = false
	pass

