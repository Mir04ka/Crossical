extends Node

const SAVE_PATH = "user://crossical.save"
const SHAPES_FOLDER = "res://"
const DEFAULT_SHAPES : Array = ["res://textures/shapes/Cross2.png", "res://textures/shapes/Circle.png", "res://textures/shapes/Romb.png", "res://textures/shapes/Star2.png"]
const DEFAULT_COLORS : Array = [Color("DA1B1B"), Color("E4DC18"), Color("1AF115"), Color("0FF2E5"), Color("1560F1"), Color("8000FF"), Color("EB09E2"), Color("F11572"), Color("000000"), Color("FFFFFF")]
const DEFAULT_LANGUAGES : Array = ["en", "ru"]

@onready var main_theme : Theme = preload("res://styles/main_theme.tres")
@onready var stylebox_button : StyleBoxFlat = preload("res://styles/stylebox_flat.tres")

var shapes: Array

var last_scene : NodePath #for state machine
var players_count : int = 2 #for game start

var primary_color : int = 9 : 
	set(new_value):
		primary_color = new_value
		_save_data()
		_update_theme()

var secondary_color : int = 8 : 
	set(new_value):
		secondary_color = new_value
		_save_data()
		_update_theme()

var choosen_shapes : Array = [0, 1, 2, 3] : 
	set(new_value):
		choosen_shapes = new_value
		_save_data()

var shape_path : Array = DEFAULT_SHAPES :
	set(new_value):
		shape_path = new_value
		_save_data()

var volume : int = 100 : 
	set(new_value):
		volume = new_value
		if volume > 100:
			volume = 100
		elif volume < 0:
			volume = 0
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), (80 * new_value / 100 - 80))
		_save_data()

var language : String : 
	set(new_value):
		language = new_value
		TranslationServer.set_locale(language)
		_save_data()

func _ready():
	_load_data()
	_load_shapes()

func _load_shapes():
	for i in shape_path:
		shapes.append(load(i))
 
func get_shape(count: int):
	if count > shapes.size():
		return null;
	
	return shapes[count]

func _get_data():
	var data = {
		"primary_color": primary_color,
		"secondary_color": secondary_color,
		"choosen_shapes": choosen_shapes,
		"shape_path": shape_path,
		"volume": volume,
		"language": language
	}
	return data

func _set_data(file_data : Dictionary):
	if file_data.has("primary_color"): 
		primary_color = int(file_data["primary_color"])
	if file_data.has("secondary_color"): 
		secondary_color = int(file_data["secondary_color"])
	if file_data.has("choosen_shapes"): 
		choosen_shapes = file_data["choosen_shapes"]
	if file_data.has("shape_path"): 
		shape_path = file_data["shape_path"]
	if file_data.has("volume"): 
		volume = file_data["volume"]
	
	if file_data.has("language"): 
		language = String(file_data["language"])
	elif DEFAULT_LANGUAGES.has(TranslationServer.get_locale()):
		language = TranslationServer.get_locale()
	else:
		language = 'en'
	
	_update_theme()

func _load_data():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		_set_data(file.get_var())
		file.close()

func _save_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(_get_data())
	file.close()

func get_primary_color():
	return DEFAULT_COLORS[primary_color]

func get_secondary_color():
	return DEFAULT_COLORS[secondary_color]

func _update_theme():
	main_theme.set_color("font_color", "Label", DEFAULT_COLORS[primary_color])
	main_theme.set_color("font_color", "Button", DEFAULT_COLORS[primary_color])
	main_theme.set_color("font_focus_color", "Button", DEFAULT_COLORS[primary_color])
	main_theme.set_color("font_hover_color", "Button", DEFAULT_COLORS[primary_color])
	main_theme.set_color("font_hover_pressed_color", "Button", DEFAULT_COLORS[primary_color])
	main_theme.set_color("font_pressed_color", "Button", DEFAULT_COLORS[primary_color])
	main_theme.set_color("icon_focus_color", "Button", DEFAULT_COLORS[primary_color])
	main_theme.set_color("icon_hover_color", "Button", DEFAULT_COLORS[primary_color])
	main_theme.set_color("icon_hover_pressed_color", "Button", DEFAULT_COLORS[primary_color])
	main_theme.set_color("icon_normal_color", "Button", DEFAULT_COLORS[primary_color])
	main_theme.set_color("icon_pressed_color", "Button", DEFAULT_COLORS[primary_color])
	RenderingServer.set_default_clear_color(DEFAULT_COLORS[secondary_color])
