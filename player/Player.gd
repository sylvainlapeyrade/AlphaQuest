extends KinematicBody2D

var speed = 50  # How fast the Player will move (pixels/sec). def = 50
var screen_size  # Size of the game window.
var is_player_alive = true
var direction = "down"
var key_collected = 0
var coin_collected = 0
var sword_possessed = false
var parent = null
var can_interact = false
var player_health = 100
var in_monster_range = false
var blink_timer = null
onready var target = null
var player_damage = 10
var game_won = false

func _ready():
	screen_size = get_viewport_rect().size
	updatePlayerHealth()
	setup_timer_blink()
	if get_owner().get_name()=="Level2":
		sword_possessed = true
	elif get_owner().get_name()=="Level3":
		sword_possessed = true
		player_damage = 30
	
func _physics_process(delta):
	move_and_collide(Vector2(0, 0))
	if player_health <= 0 && is_player_alive:
		player_health = 0		
		updatePlayerHealth()
		is_player_alive = false
		get_owner().game_over()

func _process(delta):
	if Input && !game_won:
		interpret_input(delta)
		
func interpret_input(delta):
	if is_player_alive == true:
		var velocity = Vector2.ZERO  # The player's movement vector.
		if Input.is_action_just_pressed("ui_accept"):
			if can_interact == false:
				if sword_possessed:
					if direction == "right":
						$AnimatedSprite.play("attack_right")
					elif direction == "left":
						$AnimatedSprite.play("attack_left")
					elif direction == "up":
						$AnimatedSprite.play("attack_up")
					elif direction == "down":
						$AnimatedSprite.play("attack_down")
					if in_monster_range:
							attack()
					return
			elif "NPC" in parent:
				get_owner().get_node("TileMap/NPCs/"+parent).dialog()
				if parent == "NPC2":
					if coin_collected >= 10:
						coin_collected = -10
						get_owner().get_node("CanvasLayer/GUI/Coin/CoinCounter").set_text(str(coin_collected))
						get_owner().get_node("TileMap/NPCs/"+parent).take_gold()
			
		# Test prevent diagonals movements	
		if Input.is_action_pressed("ui_right") and !Input.is_action_pressed("ui_up"):
			velocity.x += 1
			$AnimatedSprite.play("right")
			direction = "right"
		if Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_down"):
			velocity.x -= 1
			$AnimatedSprite.play("left")
			direction = "left"
		if Input.is_action_pressed("ui_down") and !Input.is_action_pressed("ui_right"):
			velocity.y += 1
			$AnimatedSprite.play("down")
			direction = "down"
		if Input.is_action_pressed("ui_up") and !Input.is_action_pressed("ui_left"):
			velocity.y -= 1
			$AnimatedSprite.play("up")
			direction = "up"
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			updatePosition(velocity, delta);
		else:
			if direction == "right":
				$AnimatedSprite.play("idle_right")
			elif direction == "left":
				$AnimatedSprite.play("idle_left")
			elif direction == "up":
				$AnimatedSprite.play("idle_up")
			elif direction == "down":
				$AnimatedSprite.play("idle_down")

func take_damage(damage):
	player_health -= damage
	updatePlayerHealth()
	#To make sprite turn to black (Opacity)
	get_node("AnimatedSprite").modulate = Color(0,0,0,0.5)
	blink_timer.start()

func defeat_monster(health_gained):
	player_health += health_gained
	if player_health > 100:
		player_health = 100
	updatePlayerHealth()

func setup_timer_blink():
	blink_timer = Timer.new()
	blink_timer.set_one_shot(true)
	blink_timer.set_wait_time(0.15)
	blink_timer.connect("timeout", self, "on_blink_timeout_complete")
	add_child(blink_timer)

func on_blink_timeout_complete():
	get_node("AnimatedSprite").modulate = Color(1,1,1,1) #Return to normal opacity
	
func attack():
	target.take_damage(player_damage)

func updatePlayerHealth():
	get_owner().get_node("CanvasLayer/GUI/HPCounter").set_text("HP: "+str(player_health))

func updatePosition(velocity, delta):
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func _on_Area2D_area_entered(area):
	parent = area.get_parent().get_name()
	if "NPC" in parent:
		can_interact = true

func _on_Area2D_area_exited(area):
	parent = null
	can_interact = false

func _on_Area2D_body_entered(body):
	if "Monster" in body.get_name():
		in_monster_range = true
		target = body

func _on_Area2D_body_exited(body):
	if "Monster" in body.get_name():
		in_monster_range = false
		target = null
