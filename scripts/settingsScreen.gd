extends Control

func _enter_tree():
	var prim_color = ResourceManager.get_primary_color()
	
	%LinkButton.add_theme_color_override("font_color", prim_color)
	%LinkButton.add_theme_color_override("font_focus_color", prim_color)
	%LinkButton.add_theme_color_override("font_hover_color", prim_color)
	%LinkButton.add_theme_color_override("font_pressed_color", prim_color)
	
	%RulesLabel.text = tr('htp1') + '\n\n' + tr('htp2') + '\n\n' + tr('htp3') + '\n\n' + tr('htp4') + '\n\n' + tr('htp5')
	
	%AnimationPlayer.play("appear")

func _on_settings_button_pressed():
	%AnimationPlayer.play("disappear")

func change_scene():
	get_tree().change_scene_to_file("res://scenes/mainMenuScreen.tscn")
