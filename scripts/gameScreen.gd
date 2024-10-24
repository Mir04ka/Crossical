extends Control


func _enter_tree():
	%WinnerPage.color = Color(ResourceManager.get_secondary_color(), 0.8)
	%WinnerTexture.modulate = ResourceManager.get_primary_color()
	
	%Game.start_game()
	%AnimationPlayer.play("appear")

func _go_main_menu():
	%AnimationPlayer.play("disappear")
	await %AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/mainMenuScreen.tscn")

func _on_settings_button_pressed():
	_go_main_menu()

func _on_mm_button_pressed():
	%AnimationPlayer.play("close_from_winner")
	await %AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/mainMenuScreen.tscn")

func _on_watch_button_pressed():
	%AnimationPlayer.play("close_winner")
