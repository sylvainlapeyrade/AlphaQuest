extends Control

var scene_path_to_load

func _ready():
	$Menu/CenterRow/Buttons/NewGameButton.grab_focus()

func _physics_process(delta):
	for button in $Menu/CenterRow/Buttons.get_children():
		if button.is_hovered() == true:
			button.grab_focus()

func _on_FadeIn_fade_finished():
	$FadeIn.hide()
	get_tree().change_scene(scene_path_to_load)

func _on_NewGameButton_pressed():
	$FadeIn.show()
	$FadeIn.fade_in()
	scene_path_to_load = "res://game/level1/Level1.tscn"

func _on_ContinueButton_pressed():
	$FadeIn.show()
	$FadeIn.fade_in()
	scene_path_to_load = "res://title_screen/TitleScreen.tscn"
	
func _on_OptionsButton_pressed():
	$FadeIn.show()
	$FadeIn.fade_in()
	scene_path_to_load = "res://title_screen/TitleScreen.tscn"

func _on_Exit_pressed():
	$FadeIn.show()
	$FadeIn.fade_in()
	get_tree().quit()