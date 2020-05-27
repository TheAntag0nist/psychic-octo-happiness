extends KinematicBody2D

var scene_4 = load("res://scenes/game_over.tscn")

#signals
signal player_stats_changed
signal dead
#game_stats
var end_of_game = false
#player stats
var health = 100
var health_max = 100
var health_regeneration = 1
var mana = 100
var mana_max = 100
var mana_regeneration = 2
export var speed = 400
var count_of_enemies = 4
var i =0
#movemant
var velocity = Vector2(0,0)
var default_vector
var mouse_pos=Vector2()
#attack
var _attack_bool=false
var attack_anim=Vector2()
var attack_vector=Vector2()
#attack
var attack_cooldown_time = 500
var next_attack_time = 0
var attack_damage = 30
var now

func _ready():
	emit_signal("player_stats_changed", self)

func movement():
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if (Input.is_action_pressed("attack") || Input.is_mouse_button_pressed(BUTTON_LEFT)) && velocity.x==0 && velocity.y==0:
		now = OS.get_ticks_msec()
		if now>= next_attack_time:
			_attack_bool=true
			var target = $RayCast2D.get_collider()
			if target != null:
				for i in range(count_of_enemies):
					if target.name.find("goblin_"+str(i)) >= 0:
						# goblin hit!
						target.hit(attack_damage)
			next_attack_time = now + attack_cooldown_time
			
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		_attack_bool=false
	elif attack_anim.length() > 0:
		attack_anim = attack_anim.normalized()
	else:
		velocity = Vector2(0,0)
		_attack_bool=false
	$AnimatedSprite.play()
	
	#animation
	if health <0:
		dead_pl()
		set_process(false)
	elif _attack_bool==true:
		attack()
	elif velocity.y < 0 and velocity.x < 0:
		$AnimatedSprite.animation="up_left"
		default_vector = "up_left" 
	elif velocity.y < 0 and velocity.x > 0:
			$AnimatedSprite.animation="up_right"
			default_vector = "up_right"
	elif velocity.y < 0 and velocity.x==0:
			$AnimatedSprite.animation="up"
			default_vector = "up"
	elif velocity.y > 0 and velocity.x < 0:
		$AnimatedSprite.animation="down_left"
		default_vector = "down_left"
	elif velocity.y > 0 and velocity.x > 0:
		$AnimatedSprite.animation="down_right"
		default_vector = "down_right"
	elif velocity.y > 0 and velocity.x==0:
		$AnimatedSprite.animation="down"
		default_vector = "down"
	elif velocity.y==0 and velocity.x > 0:
		$AnimatedSprite.animation="right"
		default_vector = "right"
	elif velocity.y==0 and velocity.x < 0:
		$AnimatedSprite.animation="left"
		default_vector = "left"
	elif velocity.x==0 and velocity.y==0 and default_vector=="left":
		$AnimatedSprite.animation="default_left"
	elif velocity.x==0 and velocity.y==0 and default_vector=="right":
		$AnimatedSprite.animation="default_right"
	elif velocity.x==0 and velocity.y==0 and default_vector=="up":
		$AnimatedSprite.animation="default_up"
	elif velocity.x==0 and velocity.y==0 and default_vector=="down":
		$AnimatedSprite.animation="default_down"
	elif velocity.x==0 and velocity.y==0 and default_vector=="up_left":
		$AnimatedSprite.animation="default_up_left"
	elif velocity.x==0 and velocity.y==0 and default_vector=="up_right":
		$AnimatedSprite.animation="default_up_right"
	elif velocity.x==0 and velocity.y==0 and default_vector=="down_left":
		$AnimatedSprite.animation="default_down_left"
	elif velocity.x==0 and velocity.y==0 and default_vector=="down_right":
			$AnimatedSprite.animation="default_down_right"
	pass

func attack():
	if default_vector=="up":
		$AnimatedSprite.animation="attack_up"
	elif default_vector=="down":
		$AnimatedSprite.animation="attack_down"
	elif default_vector=="right":
		$AnimatedSprite.animation="attack_right"
	elif default_vector=="left":
		$AnimatedSprite.animation="attack_left"
	elif default_vector=="up_left":
		$AnimatedSprite.animation="attack_up_left"
	elif default_vector=="up_right":
		$AnimatedSprite.animation="attack_up_right"
	elif default_vector=="down_left":
		$AnimatedSprite.animation="attack_down_left"
	elif default_vector=="down_right":
		$AnimatedSprite.animation="attack_down_right"
	pass
	
func dead_pl():
	if velocity.y < 0 and velocity.x < 0 or default_vector=="up_left":
		$AnimatedSprite.animation="dead_up_left"
	elif velocity.y < 0 and velocity.x > 0 or default_vector=="up_right":
			$AnimatedSprite.animation="dead_up_right"
	elif velocity.y < 0 and velocity.x==0 or default_vector=="up":
			$AnimatedSprite.animation="dead_up"
	elif velocity.y > 0 and velocity.x < 0 or default_vector=="down_left":
		$AnimatedSprite.animation="dead_down_left"
	elif velocity.y > 0 and velocity.x > 0 or default_vector=="down_right":
		$AnimatedSprite.animation="dead_down_right"
	elif velocity.y > 0 and velocity.x==0 or default_vector=="down":
		$AnimatedSprite.animation="dead_down"
	elif velocity.y==0 and velocity.x > 0 or default_vector=="right":
		$AnimatedSprite.animation="dead_right"
	elif velocity.y==0 and velocity.x < 0 or default_vector=="left":
		$AnimatedSprite.animation="daed_left"
	velocity = Vector2(0,0)
	pass

func hit(damage):
	health -= damage
	if health > 0:
		$AnimationPlayer.play("Hit")
	else:
		movement()

func _physics_process(delta):
	attack_anim=Vector2(0,0)
	mouse_pos=get_global_mouse_position()
	attack_vector.x=self.position.x
	attack_vector.y=self.position.y
	attack_anim=mouse_pos-attack_vector
	if velocity != Vector2(0,0):
		$RayCast2D.cast_to = velocity.normalized() * 50
	elif Input.is_mouse_button_pressed(BUTTON_LEFT):
		$RayCast2D.cast_to = attack_anim.normalized() * 50
		
	# Regenerates mana
	if health>0:
		var new_mana = min(mana + mana_regeneration * delta, mana_max)
		if new_mana != mana:
			mana = new_mana
			emit_signal("player_stats_changed", self)
	
		# Regenerates health
		var new_health = min(health + health_regeneration * delta, health_max)
		if new_health != health:
			health = new_health
			emit_signal("player_stats_changed", self)
	elif health<=0:
		emit_signal("dead") 
	velocity = Vector2()
	movement()
	velocity = move_and_slide(velocity)
	pass


func _on_AnimatedSprite_animation_finished():
	_attack_bool=false
	pass # Replace with function body.
