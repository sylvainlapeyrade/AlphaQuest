extends Area2D

func _ready():
	pass

func _on_Fire_body_entered(body):
	if "Player" in body.get_name(): 
		body.take_damage(10)
