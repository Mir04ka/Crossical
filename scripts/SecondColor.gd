extends HSlider

func _ready():
	value = ResourceManager.alpha
	_on_value_changed(value)

func _on_value_changed(value):
	ResourceManager.alpha = value
	
	%"9Texture".modulate = ResourceManager.get_second_color()
	%MinimapGrid.modulate = ResourceManager.get_second_color()
	%TurnIndicator.update_color()
