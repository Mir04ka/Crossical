extends ColorPickerButton

#func _ready():
#	color = ResourceManager.main_color
#	_on_color_changed(color)

func _on_color_changed(color):
	ResourceManager.main_color = color
	
	%Game.self_modulate = color
	%MainGrid.modulate = color
	%TurnIndicator.update_color()
	
	%"9Texture".modulate = ResourceManager.get_second_color()
	%MinimapGrid.modulate = ResourceManager.get_second_color()
	%TurnIndicator.update_color()
