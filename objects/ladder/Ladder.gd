extends Area2D

func _ready():
	pass # Replace with function body.

func _on_Ladder_body_entered(body):
	if get_owner().get_name() == "Level1":
		if body.get_name() == "Player":
			get_tree().change_scene("res://game/level2/Level2.tscn")
	elif get_owner().get_name() == "Level2":
			get_tree().change_scene("res://game/level3/Level3.tscn")
