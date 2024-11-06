extends GridContainer

func clear():
	for i in get_children():
		i.get_children()[0].texture = null

func set_cell(pos: int, turn: int):
	var textureRect : TextureRect = get_children()[pos].get_children()[0]
	
	if textureRect.texture == null:
		textureRect.texture = ResourceManager.get_shape(turn)
		textureRect.modulate.a = 0
		var tween = create_tween()
		tween.tween_property(textureRect, "modulate:a", 1, 0.2).set_trans(Tween.TRANS_BOUNCE)
		return
	
	if textureRect.texture != ResourceManager.get_shape(turn):
		var tween = create_tween()
		tween.tween_property(textureRect, "modulate:a", 0, 0.1).set_trans(Tween.TRANS_BOUNCE)
		await tween.finished
		textureRect.texture = ResourceManager.get_shape(turn)
		var tween2 = create_tween()
		tween2.tween_property(textureRect, "modulate:a", 1, 0.1).set_trans(Tween.TRANS_BOUNCE)
 
func _ready():
	$"..".custom_minimum_size = Vector2i((get_viewport_rect().size.x - 20) / 3, (get_viewport_rect().size.x - 20) / 3)
	
	clear()

func exit():
	for i in get_children():
		var tween = create_tween()
		tween.tween_property(i.get_children()[0], "modulate:a", 0, 0.3).set_trans(Tween.TRANS_BOUNCE)
