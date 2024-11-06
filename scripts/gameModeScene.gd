extends Control

func _enter_tree():
	if GameSaver.save_exist == true:
		%continueButton.modulate.a = 255
		print("yaya")
	else:
		%continueButton.modulate.a = 0
		print("booo")
	
	%AnimationPlayer.play("appear")

func _on_back_button_pressed():
	%AnimationPlayer.play("click_back")

func go_back():
	get_tree().change_scene_to_file("res://scenes/mainMenuScreen.tscn")


func _on_button_2_pressed():
	ResourceManager.players_count = 2
	
	%AnimationPlayer.play("click_play_2")

func go_to_game():
	get_tree().change_scene_to_file("res://scenes/gameScreen.tscn")


func _on_button_3_pressed():
	ResourceManager.players_count = 3
	
	%AnimationPlayer.play("click_play_3")

func _on_button_4_pressed():
	ResourceManager.players_count = 4
	
	%AnimationPlayer.play("click_play_4")

func _on_continue_button_pressed():
	%AnimationPlayer.play("click_play_continue")
	await %AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/gameScreen.tscn")
