extends Node2D

var scene_path_to_load

func _ready():
	print_screen_typed("Hello adventurer, are you ready for your quest?")

func print_screen(message, displaytime):
	get_node("CanvasLayer/Message").set_bbcode("[center]"+message+"[/center]")
	get_node("CanvasLayer/Message/Timer").start(displaytime)

func print_screen_typed(message):
	var present_message = ""
	for letter in message:
		present_message += str(letter)
		get_node("CanvasLayer/Message/Timer2").start(0.1)
		get_node("CanvasLayer/Message").set_bbcode("[center]"+present_message+"[/center]")
		yield(get_node("CanvasLayer/Message/Timer2"), "timeout")

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://title_screen/TitleScreen.tscn")

func _on_Timer_timeout():
	get_node("CanvasLayer/Message").set_text("")

func _on_Timer2_timeout():
	get_node("CanvasLayer/Message/Timer").start(0.1)