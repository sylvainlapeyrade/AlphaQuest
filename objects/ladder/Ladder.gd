extends Area2D

func _ready():
	pass # Replace with function body.

func _on_Ladder_body_entered(body):
	get_tree().change_scene("res://title_screen/TitleScreen.tscn")
