extends Node2D

var gameOverScene = preload("res://game/gameOver/GameOver.tscn")

func _ready():
	get_node("CanvasLayer/GUI").print_screen_typed("I can feel Chtoune is very close... Be careful of the lava.", 5)
	
func game_over():
	get_node("AudioStreamPlayer").stop()
	get_node("TileMap/Player/AnimatedSprite").hide()
	get_node("CanvasLayer/GameOver").show()

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://title_screen/TitleScreen.tscn")