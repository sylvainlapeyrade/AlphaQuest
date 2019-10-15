extends KinematicBody2D


func _ready():
	$AnimatedSprite.animation = self.get_name()
	
func dialog():
	if self.get_name() == "NPC1":
		if get_owner().get_name() == "Level1": 
			get_owner().print_screen_typed("I have seen monsters in this area! \n" +\
			 "You need a weapon, go to the chest behind me.", 3)
		elif get_owner().get_name() == "Level2":
			get_owner().print_screen_typed("Be careful the fire of Zog is everywhere! \n" +\
			"Do not step on it !", 3)
	elif self.get_name() == "NPC2":
		get_owner().print_screen_typed("Take the ladder to go to the next level! \n" +
										"But first you have to give me 10 coins!", 3)

func take_gold():
	queue_free()