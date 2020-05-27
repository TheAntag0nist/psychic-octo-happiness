extends KinematicBody2D

#signals
signal dead

#logic enemies
var velocity = Vector2(0,0)
var player_velocity = Vector2()
var diff_vect = Vector2()
var following = false
var distance
var attack_cooldown_time = 400
var next_attack_time = 0
var attack_vect=Vector2()

# goblin stats
var health = 100
var health_max = 100
var health_regeneration = 1
export var distance_comp=200
export var min_speed = 100
var attack_damage=5

#get node player
onready var Player = get_parent().get_node("Player")

func dead_mob():
	if health <= 0:
		velocity = Vector2(0,0)
		set_process(false)
		get_tree().queue_delete(self)
	pass

func find_player():
	player_velocity.x = Player.position.x
	player_velocity.y = Player.position.y
	velocity.x = self.position.x
	velocity.y = self.position.y
	diff_vect = player_velocity - velocity
	distance = sqrt(diff_vect.x*diff_vect.x+diff_vect.y*diff_vect.y)
	if distance < distance_comp && distance>50:
		following = true
	elif distance<=50:
		following=false
		attack()
	pass

func movement():
	find_player()
	if following == true:
		velocity = diff_vect.normalized() * min_speed
	else:
		velocity = Vector2(0,0)
	velocity = move_and_slide(velocity)
	pass

func hit(damage):
	health -= damage
	if health > 0:
		$AnimationPlayer.play("Hit")
	else:
		dead_mob()

func attack():
	var now = OS.get_ticks_msec()
	if now>= next_attack_time:
		var target = $RayCast2D.get_collider()
		if target != null:
			if target.name.find("Player") >= 0:
			# Player hit!
				target.hit(attack_damage)
		next_attack_time = now + attack_cooldown_time
	pass

func _physics_process(delta):
	health = min(health + health_regeneration * delta, health_max)
	attack_vect = diff_vect
	$RayCast2D.cast_to = attack_vect.normalized() * 40
	dead_mob()
	movement()
	pass
