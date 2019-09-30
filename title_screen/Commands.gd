extends Node2D

func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		 get_tree().change_scene("res://title_screen/TitleScreen.tscn")


func _on_Button_pressed():
	get_tree().change_scene("res://title_screen/TitleScreen.tscn")
