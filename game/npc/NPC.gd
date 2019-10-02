extends KinematicBody2D


func _ready():
	$AnimatedSprite.animation = self.get_name()
	
func dialog():
	print("test")
	if self.get_name() == "NPC1":
		get_owner().print_screen_typed("Hello adventurer, I have seen monsters in this area, " +\
		 "you need a weapon, go to the chest behind me.", 3)
	elif self.get_name() == "NPC2":
		get_owner().print_screen_typed("Take the ladder to go to the next level!", 3)