extends Area2D

func _ready():
	if self.get_name() == "ChestLock":
		$AnimatedSprite.animation = "chestopenlocked"
	else:
		$AnimatedSprite.animation = "chestopen"

func _on_Chest_body_entered(body):
	if body.get_name() == "Player" && get_owner() != null:
		if self.get_name() == "ChestSword":
			body.sword_possessed = 1
			$AnimatedSprite.frame = 1
			get_owner().print_screen("You have found the Great Flying Sword, you can now attack with it.", 10)
		elif self.get_name() == "ChestLock":
			if body.key_collected > 0:
				$AnimatedSprite.frame = 1
			else:
				get_owner().print_screen("You need a key to open this chest!", 5)