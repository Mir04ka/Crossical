extends HBoxContainer

var active_indicators: Array

func setup(pl_count: int):
	var players_count = pl_count
	var j = 0
	
	for i in get_children():
		i.visible = true
		i.texture = ResourceManager.get_shape(j)
		active_indicators.append(i)
		j += 1
		if j > players_count: 
			i.visible = false

func set_active(now_turn: int): 
	for i in active_indicators:
		i.self_modulate = Color(ResourceManager.get_primary_color(), 0.5)
	active_indicators[now_turn].self_modulate = ResourceManager.get_primary_color()

func update_color():
	if %Game.is_started:
		for i in active_indicators:
			i.self_modulate = Color(ResourceManager.get_primary_color(), 0.5)
		active_indicators[%Game.turn].self_modulate = ResourceManager.get_primary_color()
