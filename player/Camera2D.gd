extends Camera2D

func _ready():
	_auto_set_limits()

func _auto_set_limits():
	for tilemap in get_tree().get_nodes_in_group("tilemap"):
		if tilemap is TileMap:
			
			var used = tilemap.get_used_rect()
			var scale = tilemap.scale
			var cell_size = tilemap.cell_size
			
			limit_left = min(used.position.x * cell_size.x * scale.x, 0)
			limit_right = max(used.end.x * cell_size.x * scale.x, 0)
			limit_top = min(used.position.y * cell_size.y * scale.y, 0)
			limit_bottom = max(used.end.y * cell_size.y * scale.y, 0)
	