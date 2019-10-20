extends Node2D

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	for button in $Buttons.get_children():
		if button.is_hovered() == true:
			button.grab_focus()
	
func _on_Exit_pressed():
	get_tree().quit()

func _on_TryAgainButton_pressed():
	if get_owner().get_name() == "Level1":
		get_tree().change_scene("res://game/level1/Level1.tscn")
	if get_owner().get_name() == "Level2":
		get_tree().change_scene("res://game/level2/Level2.tscn")
	if get_owner().get_name() == "Level3":
		get_tree().change_scene("res://game/level3/Level3.tscn")

func _on_GameOver_visibility_changed():
	$Buttons/TryAgainButton.grab_focus()
	get_node("AudioStreamPlayer").play()
