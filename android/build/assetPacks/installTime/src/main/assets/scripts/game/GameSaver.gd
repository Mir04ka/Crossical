extends Node

const SAVE_PATH = "user://match.save"

var save_exist : bool = false

var players_count : int :
	set(new_value):
		players_count = new_value
		_save_data()

var turn: int :
	set(new_value):
		turn = new_value
		_save_data()

var map9: Array[Array] :
	set(new_value):
		map9 = new_value
		_save_data()

var map3: Array[Array] :
	set(new_value):
		map3 = new_value
		_save_data()

func _get_data():
	var data = {
		"map9": map9,
		"map3": map3,
		"turn": turn,
		"players_count": players_count
	}
	return data

func _set_data(file_data : Dictionary):
	if not (file_data.has("map9") || file_data.has("map3") || file_data.has("turn") || file_data.has("players_count")): 
		save_exist = false
		print("NOT exist")
		return
	
	save_exist = true
	print("exist")

func _load_data():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		_set_data(file.get_var())
		file.close()
		save_exist = true
	else:
		save_exist = false

func _save_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(_get_data())
	file.close()

func clear_save():
	var dir = DirAccess.open("user://")
	dir.remove("match.save")
	_ready()

func fill_save(players_count: int, turn: int, map9: Array[Array], map3: Array[Array]):
	self.players_count = players_count
	self.turn = turn
	self.map9 = map9
	self.map3 = map3
	
	save_exist = true

func _ready():
	_load_data()
	print(save_exist)
