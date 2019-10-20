extends KinematicBody2D
onready var target = $"../../Player"
var monster_speed = 75  # How fast the Monster will move (pixels/sec). def = 30
var ai_think_time = 0.7
var ai_think_time_timer = null
var monster_health = 50
var player_attack_range = false
var player_move_range = false
var start_position = null
var blink_timer = null

func _ready():
	if get_owner().get_name() == "Level1": 
		get_node("AnimatedSprite").play("bat")
	elif get_owner().get_name() == "Level2":
		get_node("AnimatedSprite").play("ghost")
	elif get_owner().get_name() == "Level3":
		get_node("AnimatedSprite").play("boss")
		monster_health += 1950
		monster_speed = 50
		var ai_think_time = 2
		
	setup_ai_think_time_timer()
	start_position = self.position
	setup_timer_blink()
	
func _process(delta):
	if monster_health <= 0:
		target.defeat_monster(10)
		queue_free()
		if get_owner().get_name() == "Level3":
			get_owner().game_win()
	if player_attack_range && ai_think_time_timer.time_left == 0 && target.is_player_alive:
		decide_to_attack()
	elif player_move_range && target.is_player_alive:
		ai_move(target.position)
	else:
		ai_move(start_position)
	
func ai_get_direction(desired_positon):
	return desired_positon - self.position

func ai_move(desired_positon):
	var direction = ai_get_direction(desired_positon)
	var motion = direction.normalized() * monster_speed
	move_and_slide(motion)
	
func setup_ai_think_time_timer():
	ai_think_time_timer = Timer.new()
	ai_think_time_timer.set_one_shot(true)
	ai_think_time_timer.set_wait_time(ai_think_time)
	ai_think_time_timer.connect("timeout", self, "on_ai_thinktime_timeout_complete")
	add_child(ai_think_time_timer)

func setup_timer_blink():
	blink_timer = Timer.new()
	blink_timer.set_one_shot(true)
	blink_timer.set_wait_time(0.15)
	blink_timer.connect("timeout", self, "on_blink_timeout_complete")
	add_child(blink_timer)
	
func on_blink_timeout_complete():
#	#Return to normal opacity
	get_node("AnimatedSprite").modulate = Color(1,1,1,1)

func take_damage(damage):
	monster_health -= damage
	#To make sprite turn to black (Opacity)
	get_node("AnimatedSprite").modulate = Color(0,0,0,0.5)
	blink_timer.start()
	
func attack():
	if get_owner().get_name() == "Level1": 
		target.take_damage(5)
	elif get_owner().get_name() == "Level2": 
		target.take_damage(10)
	elif get_owner().get_name() == "Level3": 
		target.take_damage(20)

func decide_to_attack():
	ai_think_time_timer.start()

func on_ai_thinktime_timeout_complete():
	if player_attack_range:
		attack()

func _on_MeleeRange_body_entered(body):
	if body.get_name() == "Player":
		player_attack_range = true
		if get_owner().get_name() == "Level1": 
			get_node("AnimatedSprite").play("bat_attack")
		elif get_owner().get_name() == "Level2":
			get_node("AnimatedSprite").play("ghost_attack")
		elif get_owner().get_name() == "Level3":
			get_node("AnimatedSprite").play("boss_attack")

func _on_MeleeRange_body_exited(body):
	if body.get_name() == "Player" && get_owner() != null:
		player_attack_range = false
		if get_owner().get_name() == "Level1": 
			get_node("AnimatedSprite").play("bat")
		elif get_owner().get_name() == "Level2":
			get_node("AnimatedSprite").play("ghost")
		elif get_owner().get_name() == "Level3":
			get_node("AnimatedSprite").play("boss")

func _on_AgressionRange_body_entered(body):
	if body.get_name() == "Player":
		player_move_range = true

func _on_AgressionRange_body_exited(body):
	if body.get_name() == "Player":
		player_move_range = false