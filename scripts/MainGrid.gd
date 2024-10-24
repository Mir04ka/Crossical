extends GridContainer

var is_game_active : bool

func clear():
	for i in get_children():
		i.icon = null
		i.disabled = false

func _update_pivot():
	var pivot : Vector2 = $Button.size / (Vector2.ONE * 2)
	for i in range(get_child_count()):
		get_children()[i].pivot_offset = pivot

func _ready():
	for i in 80:
		add_child($Button.duplicate())
	
	for i in range(get_child_count()):
		get_children()[i].pressed.connect(_on_grid_clicked.bind(i))
	
	$Button.resized.connect(_update_pivot.bind())
	
	_update_pivot()
	clear()

func _on_grid_clicked(button_num: int):
	if is_game_active:
		%TurnAudio.play()
		get_children()[button_num].disabled = true
		get_children()[button_num].icon = ResourceManager.get_shape($"..".turn)
		
		get_children()[button_num].scale = Vector2(1.2, 1.2)
		var tween = create_tween()
		tween.tween_property(get_children()[button_num], "scale", Vector2.ONE, 0.3).set_trans(Tween.TRANS_SINE)
		$"..".next_turn(button_num)

func exit():
	for i in get_children():
		var tween = create_tween()
		tween.tween_property(i, "scale", Vector2.ZERO, 0.3).set_trans(Tween.TRANS_BOUNCE)
		tween.tween_interval(2)
