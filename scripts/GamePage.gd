extends PanelContainer

func _ready():
	visible = true

func _on_settings_button_pressed():
	%SettingsPage.visible = true
