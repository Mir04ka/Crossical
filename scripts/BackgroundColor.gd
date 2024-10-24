extends ColorPickerButton

func _ready():
	color = ResourceManager.background_color
	_on_color_changed(color)

func _on_color_changed(color):
	ResourceManager.background_color = color
	
	$"../../../../../..".color = color
	%MMBackground.color = color
	%SettingsBackground.color = color
