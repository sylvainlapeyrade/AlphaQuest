extends Area2D

export var value = 1

func _ready():
	pass

func _on_Key_body_entered(body):
	if get_owner() != null:
		if body.get_name() == "Player":
			body.key_collected += value
			get_owner().get_node("CanvasLayer/GUI/Key/KeyCounter").set_text(str(body.key_collected))
		$AnimationPlayer.play("Key_collected")
		queue_free()