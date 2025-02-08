extends MarginContainer

@onready var game = %Game

func _ready():
	visible = true

func _on_menu_settings_button_pressed():
	%SettingsPage.visible = true

func _on_play_2_button_pressed():
	game.start_game(2)
	visible = false

func _on_play_3_button_pressed():
	game.start_game(3)
	visible = false

func _on_play_4_button_pressed():
	game.start_game(4)
	visible = false

func _on_skins_button_pressed():
	%SkinsPage.visible = true
