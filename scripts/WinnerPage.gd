extends Button

func _ready():
	visible = false

func set_winner(winner: int):
	%WinnerTexture.texture = ResourceManager.get_shape(winner)
	%WinnerTexture.modulate = ResourceManager.main_color
	$WinBackground.color = ResourceManager.background_color
	visible = true

func _on_pressed():
	%MainMenu.visible = true
	visible = false
