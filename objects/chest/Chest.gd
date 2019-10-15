extends Area2D

var chest_opened = false

func _ready():
	if self.get_name() == "ChestLock":
		$AnimatedSprite.animation = "chestopenlocked"
	else:
		$AnimatedSprite.animation = "chestopen"

func _on_Chest_body_entered(body):
	if body.get_name() == "Player" && get_owner() != null && chest_opened == false:
		if self.get_name() == "ChestSword":
			body.sword_possessed = 1
			$AnimatedSprite.frame = 1
			get_owner().print_screen("You have found the Great Flying Sword, you can now attack with it.", 5)
			chest_opened = true
		elif "ChestLock" in self.get_name():
			if body.key_collected > 0:
				$AnimatedSprite.frame = 1
				chest_opened = true
				if get_owner().get_name() == "Level1": 
					get_owner().print_screen("You have found food, now your health is full again!", 10)
					body.player_health = 100
					body.updatePlayerHealth()
				elif get_owner().get_name() == "Level2":
					get_owner().print_screen("This chest contained the blessing of the elders, you damages has been tripled!. ", 10)
					body.player_damage = 30
			else:
				get_owner().print_screen("You need a key to open this chest!", 5)
		elif "ChestLife" in self.get_name():
				$AnimatedSprite.frame = 1
				chest_opened = true
				get_owner().print_screen("You have found food, now your health is full again!", 10)
				body.player_health = 100
				body.updatePlayerHealth()
			