extends Control

func _enter_tree():
	%AnimationPlayer.play("appear")

func _on_settings_button_pressed():
	%AnimationPlayer.play("click_info")

func open_info():
	get_tree().change_scene_to_file("res://scenes/infoScreen.tscn")

func _on_play_button_pressed():
	%AnimationPlayer.play("click_play")

func open_mode():
	get_tree().change_scene_to_file("res://scenes/gameModeScene.tscn")


func _on_customisation_button_pressed():
	ResourceManager.last_scene = get_tree().current_scene.scene_file_path
	
	%AnimationPlayer.play("click_settings")

func open_customisation():
	get_tree().change_scene_to_file("res://scenes/customisationScreen.tscn")
