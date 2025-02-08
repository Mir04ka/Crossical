extends TextureRect

var is_started: bool = false
var players_count : int = 2
var turn: int
var total_turns: int
var map9: Array[Array]
var map3: Array[Array]
var is_bot: Array

@export var indicator : HBoxContainer
@export var minimap : GridContainer
@export var field : GridContainer

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST and not is_started:
		%AnimationPlayer.play("close_from_winner")

func _enter_tree():
	material.set_shader_parameter("fill_color", ResourceManager.get_primary_color())
	%"9Texture".material.set_shader_parameter("fill_color", ResourceManager.get_primary_color())
	modulate = ResourceManager.get_primary_color()
	
	#_start_game()

func load_game():
	pass

func start_game():
	indicator.setup(ResourceManager.players_count)
	indicator.set_active(0)
	
	_clear_map()
	players_count = ResourceManager.players_count
	turn = 0
	is_started = true
	total_turns = 0
	%MainGrid.is_game_active = true

func next_turn(lastTurn: int):
	var lastTurnPos: Vector2i = Vector2i(lastTurn % 9, lastTurn / 9)
	
	if map9[lastTurnPos.x][lastTurnPos.y] != -1:
		print("error")
	else:
		map9[lastTurnPos.x][lastTurnPos.y] = turn
		
		_check_field(lastTurnPos)
		
		total_turns += 1
		if total_turns == 81:
			_set_winner(-1)
		
		turn += 1
		if turn >= players_count:
			turn = 0
		
		GameSaver.fill_save(players_count, turn, map9, map3)
		
		indicator.set_active(turn)

func _check_field(last_turn: Vector2i):
	var dirs: Array = [Vector2i(1, 0), Vector2i(1, 1), Vector2i(0, 1), Vector2i(-1, 1)]
	
	for i in dirs:
		var minimap_update = _check_line(last_turn, i, turn)
		
		if minimap_update != null:
			for j in minimap_update:
				minimap.set_cell(j, turn)
				map3[j % 3][j /3] = turn
	
	_check_minimap()

func _check_minimap():
	var _to_check = [
		[[0, 0], [1, 1], [2, 2]],
		[[2, 0], [1, 1], [0, 2]],
		[[0, 0], [0, 1], [0, 2]],
		[[1, 0], [1, 1], [1, 2]],
		[[2, 0], [2, 1], [2, 2]],
		[[0, 0], [1, 0], [2, 0]],
		[[0, 1], [1, 1], [2, 1]],
		[[0, 2], [1, 2], [2, 2]]
					]
	
	for i in _to_check:
		if map3[i[0][0]][i[0][1]] == map3[i[1][0]][i[1][1]] and map3[i[0][0]][i[0][1]] == map3[i[2][0]][i[2][1]] and map3[i[0][0]][i[0][1]] != -1:
			_set_winner(turn)

func _minimap_cell(pos: Vector2i):
	var vc3: Vector2i = Vector2i(pos.x / 3, pos.y / 3)
	
	return (vc3.x + vc3.y * 3)

func _check_line(last_turn: Vector2i, dir: Vector2i, player_shape: int):
	var current_pos: Vector2i = last_turn + dir
	var minimap_cells : Array
	var count: int = 1
	
	minimap_cells.append(_minimap_cell(last_turn))
	
	if current_pos.x <= 8 and current_pos.y <= 8 and current_pos.x >= 0 and current_pos.y >= 0:
		while map9[current_pos.x][current_pos.y] == player_shape:
			count += 1 
			minimap_cells.append(_minimap_cell(current_pos))
			current_pos += dir
			if current_pos.x > 8 or current_pos.y > 8 or current_pos.x < 0 or current_pos.y < 0:
				break;
	
	dir *= -1
	current_pos = last_turn + dir
	
	if current_pos.x <= 8 and current_pos.y <= 8 and current_pos.x >= 0 and current_pos.y >= 0:
		while map9[current_pos.x][current_pos.y] == player_shape:
			count += 1
			minimap_cells.append(_minimap_cell(current_pos))
			current_pos += dir
			if current_pos.x > 8 or current_pos.y > 8 or current_pos.x < 0 or current_pos.y < 0:
				break;
	
	if count < 3:
		return null
	
	return minimap_cells

func _set_winner(player: int):
	is_started = false
	%MainGrid.is_game_active = false
	GameSaver.clear_save()
	
	if player != -1:
		%WinnerLabel.text = tr('winner')
		%WinnerTexture.texture = ResourceManager.shapes[player]
	else:
		%WinnerLabel.text = tr('tie')
		%WinnerTexture.texture = null
	
	%AnimationPlayer.play("open_winner")

func _clear_map():
	field.clear()
	map9 = []
	for i in 9:
		map9.append([]) 
		for j in 9:
			map9[i].append(-1)
	
	minimap.clear()
	map3 = []
	for i in 3:
		map3.append([]) 
		for j in 3:
			map3[i].append(-1)
