extends KinematicBody2D

export var speed = 50  # How fast the player will move (pixels/sec). def = 50
var screen_size  # Size of the game window.
var last_direction = "down"
var sword_possessed = 0
var key_collected = 0
var coin_collected = 0
var parent = null
var can_interact = false

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	move_and_collide(Vector2(0, 0))

func _process(delta):
	playerMouvement(delta);

func playerMouvement(delta):
	var velocity = Vector2.ZERO  # The player's movement vector.
	if Input.is_action_pressed("ui_accept"):
		if can_interact == false:
			if sword_possessed == 1:
				if last_direction == "right":
					$AnimatedSprite.play("attack_right")
				elif last_direction == "left":
					$AnimatedSprite.play("attack_left")
				elif last_direction == "up":
					$AnimatedSprite.play("attack_up")
				elif last_direction == "down":
					$AnimatedSprite.play("attack_down")
				return
		else:
			print(parent)
			get_owner().get_node("TileMap/NPCs/"+parent).dialog()
		
	# Test prevent diagonals movements	
	if Input.is_action_pressed("ui_right") and !Input.is_action_pressed("ui_up"):
		velocity.x += 1
		$AnimatedSprite.animation = "right"
		last_direction = "right"
	if Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_down"):
		velocity.x -= 1
		$AnimatedSprite.animation = "left"
		last_direction = "left"
	if Input.is_action_pressed("ui_down") and !Input.is_action_pressed("ui_right"):
		velocity.y += 1
		$AnimatedSprite.animation = "down"
		last_direction = "down"
	if Input.is_action_pressed("ui_up") and !Input.is_action_pressed("ui_left"):
		velocity.y -= 1
		$AnimatedSprite.animation = "up"
		last_direction = "up"
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		updatePosition(velocity, delta);
		$AnimatedSprite.play()
	else:
		if last_direction == "right":
			$AnimatedSprite.play("idle_right")
		elif last_direction == "left":
			$AnimatedSprite.play("idle_left")
		elif last_direction == "up":
			$AnimatedSprite.play("idle_up")
		elif last_direction == "down":
			$AnimatedSprite.play("idle_down")

func updatePosition(velocity, delta):
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	

func _on_Area2D_area_entered(area):
	parent = area.get_parent().get_name()
	if parent == "NPC1" or parent == "NPC2" :
		can_interact = true

func _on_Area2D_area_exited(area):
	parent = null
	can_interact = false
