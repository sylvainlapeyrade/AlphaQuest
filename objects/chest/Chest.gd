extends Area2D

func _ready():
	pass

func _on_Chest_body_entered(body):
	$AnimatedSprite.frame = 1
	if get_owner() != null:
		get_owner().sword_possessed = 1
