extends Node2D

var scene_path_to_load
var coin_total = 0
var coin_collected = 0
var sword_possessed = 0

func _ready():
	pass
	
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://title_screen/TitleScreen.tscn")