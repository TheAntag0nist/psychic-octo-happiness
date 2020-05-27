extends Popup

var already_paused
var player

func _ready():
	player = get_parent().get_parent().get_node("Player")
	pass 

func _input(event):
	if not visible:
		if Input.is_action_just_pressed("open_inv"):
			already_paused = get_tree().paused
			get_tree().paused = true
			player.set_process_input(false)
			popup()

