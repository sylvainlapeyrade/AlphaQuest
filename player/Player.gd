extends KinematicBody2D

export var speed = 50  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.
var last_direction = "down"


func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	move_and_collide(Vector2(0, 0))

func _process(delta):
	playerMouvement(delta);

func playerAttack():
	if Input.is_action_pressed("ui_select"):
		$AnimatedSprite.animation = "left"
		$AnimatedSprite.animation = "attack_left"
		$AnimatedSprite.play()

func playerMouvement(delta):
	var velocity = Vector2.ZERO  # The player's movement vector.
	if Input.is_action_pressed("ui_accept"):
		if last_direction == "right":
			$AnimatedSprite.play("attack_right")
		elif last_direction == "left":
			$AnimatedSprite.play("attack_left")
		elif last_direction == "up":
			$AnimatedSprite.play("attack_up")
		elif last_direction == "down":
			$AnimatedSprite.play("attack_down")
		return
		
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
	
