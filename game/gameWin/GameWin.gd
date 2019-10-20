extends Node2D

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	for button in $Buttons.get_children():
		if button.is_hovered() == true:
			button.grab_focus()

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://title_screen/TitleScreen.tscn")
		
func _on_Exit_pressed():
	get_tree().quit()
	
func _on_GameWin_visibility_changed():
	$Buttons/MainMenuButton.grab_focus()
	get_node("AudioStreamPlayer").play()
