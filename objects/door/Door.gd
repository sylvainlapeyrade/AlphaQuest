extends Area2D

func _ready():
	pass
	
func _on_Door_body_entered(body):
	$AnimatedSprite.frame = 1

func _on_Door_body_exited(body):
	$AnimatedSprite.frame = 0
