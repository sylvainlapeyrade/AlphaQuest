extends Node2D

func _ready():
	pass # Replace with function body.

func print_screen(message, displaytime):
	get_node("Message/RichTextLabel").set_bbcode("[center]"+message+"[/center]")
	get_node("Message/Timer").start(displaytime)
	get_node("Message/TextureRect").show()

func print_screen_typed(message, displaytime):
	var present_message = ""
	var timer = get_node("Message/Timer")
	for letter in message:
		get_node("Message/TextureRect").show()
		present_message += str(letter)
		timer.start(0.075)
		yield(timer, "timeout")
		get_node("Message/RichTextLabel").set_bbcode("[center]"+present_message+"[/center]")
	timer.start(displaytime)
	get_node("Message/TextureRect").show()
	
func _on_Timer_timeout():
	get_node("Message/RichTextLabel").set_text("")
	get_node("Message/TextureRect").hide()
