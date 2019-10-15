extends Node2D

var gameOverScene = preload("res://game/gameOver/GameOver.tscn")


func _ready():
	print_screen_typed("Greetings adventurer! Are you here to defeat the great monster Zog?", 5)
	
func print_screen(message, displaytime):
	get_node("CanvasLayer/Message").set_bbcode("[center]"+message+"[/center]")
	get_node("CanvasLayer/Message/Timer").start(displaytime)

func print_screen_typed(message, displaytime):
	var present_message = ""
	var timer = get_node("CanvasLayer/Message/Timer")
	for letter in message:
		present_message += str(letter)
		timer.start(0.1)
		yield(timer, "timeout")
		get_node("CanvasLayer/Message").set_bbcode("[center]"+present_message+"[/center]")
	timer.start(displaytime)

func game_over():
	get_node("TileMap/Player/AnimatedSprite").hide()
	get_node("CanvasLayer/GameOver").show()

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://title_screen/TitleScreen.tscn")

func _on_Timer_timeout():
	get_node("CanvasLayer/Message").set_text("")