extends Popup

var already_paused
var selected_menu

var player

func _ready():
	player = get_parent().get_parent().get_node("Player")

func change_menu_color():
	$Resume.color = Color.gray
	$Settings.color = Color.gray
	$Exit.color = Color.gray
	
	match selected_menu:
		0:
			$Resume.color = Color.greenyellow
		1:
			$Settings.color = Color.greenyellow
		2:
			$Exit.color = Color.greenyellow

func _input(event):
	if not visible:
		if Input.is_action_just_pressed("menu"):
			# Pause game
			already_paused = get_tree().paused
			get_tree().paused = true
			# Reset the popup
			selected_menu = 0
			change_menu_color()
			# Show popup
			player.set_process_input(false)
			popup()
	else:
		if Input.is_action_just_pressed("ui_down"):
			selected_menu = (selected_menu + 1) % 3;
			change_menu_color()
		elif Input.is_action_just_pressed("ui_up"):
			if selected_menu > 0:
				selected_menu = selected_menu - 1
			else:
				selected_menu = 2
			change_menu_color()
		elif Input.is_action_just_pressed("attack"):
			match selected_menu:
				0:
					# Resume game
					if not already_paused:
						get_tree().paused = false
					player.set_process_input(true)
					hide()
				1:
					pass
				2:
					# Quit game
					get_tree().quit()
