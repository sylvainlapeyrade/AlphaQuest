extends Control

var scene_path_to_load

func _ready():
	$Menu/CenterRow/Buttons/NewGameButton.grab_focus()
	for button in $Menu/CenterRow/Buttons.get_children():
		if button != $Menu/CenterRow/Buttons/Exit and button != $Menu/CenterRow/Buttons/NewGameButton:
			button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func _physics_process(delta):
	for button in $Menu/CenterRow/Buttons.get_children():
		if button.is_hovered() == true:
			button.grab_focus()

func _on_Button_pressed(scene_to_load):
	$FadeIn.show()
	$FadeIn.fade_in()
	print(scene_to_load)
	scene_path_to_load = scene_to_load


func _on_FadeIn_fade_finished():
	$FadeIn.hide()
	get_tree().change_scene(scene_path_to_load)


func _on_Exit_pressed():
	$FadeIn.show()
	$FadeIn.fade_in()
	get_tree().quit()


func _on_NewGameButton_pressed():
	$FadeIn.show()
	$FadeIn.fade_in()
	get_tree().change_scene("res://game/level1/Level1.tscn")