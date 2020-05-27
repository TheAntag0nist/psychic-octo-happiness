extends ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_player_stats_changed(var player):
	if player.health >0:
		$bar.rect_size.x = 296 * player.health / player.health_max
	else:
		$bar.rect_size.x = 2
	pass # Replace with function body.
