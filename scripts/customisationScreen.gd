extends Control

@export var colorGroup : ButtonGroup

var _is_peeking_primary : bool = true
var _is_buttons_disabled : bool = false

func _set_icon_color():
	var prim_color = ResourceManager.get_primary_color()
	var sec_color = ResourceManager.get_secondary_color()
	
	%sColorButton.add_theme_color_override("icon_normal_color", sec_color)
	%sColorButton.add_theme_color_override("icon_disabled_color", sec_color)
	%sColorButton.add_theme_color_override("icon_focus_color", sec_color)
	%sColorButton.add_theme_color_override("icon_hover_color", sec_color)
	%sColorButton.add_theme_color_override("icon_hover_pressed_color", sec_color)
	%sColorButton.add_theme_color_override("icon_pressed_color", sec_color)
	
	%LinkButton.add_theme_color_override("font_color", prim_color)
	%LinkButton.add_theme_color_override("font_focus_color", prim_color)
	%LinkButton.add_theme_color_override("font_hover_color", prim_color)
	%LinkButton.add_theme_color_override("font_pressed_color", prim_color)
	
	%ColorRect.color = Color(ResourceManager.get_secondary_color(), 0.75)

func _update_volume():
	%VolumeLabel.text = str(ResourceManager.volume) + "%"

func _ready():
	var colorButtons : Array[Button] = [%Button, %Button2, %Button3, %Button4, %Button5, %Button6, %Button7, %Button8, %Button9, %Button10]
	
	colorGroup.pressed.connect(_on_color_picked)
	
	for i in colorButtons.size():
		colorButtons[i].modulate = ResourceManager.DEFAULT_COLORS[i]
	
	_update_volume()
	_set_icon_color()

func _on_color_picked(arg):
	if not _is_buttons_disabled:
		_is_buttons_disabled = true
		var colorButtons : Array[Button] = [%Button, %Button2, %Button3, %Button4, %Button5, %Button6, %Button7, %Button8, %Button9, %Button10]
		
		var new_color = colorButtons.find(arg)
		
		%AnimationPlayer.play("close_color_peaker")
		await %AnimationPlayer.animation_finished
		var img = get_viewport().get_texture().get_image()
		%TextureRect.texture = ImageTexture.create_from_image(img)
		%TextureRect.visible = true
		%AnimationPlayer.play("change_theme")
		
		if _is_peeking_primary:
			if new_color != ResourceManager.secondary_color:
				ResourceManager.primary_color = new_color
			else:
				ResourceManager.secondary_color = ResourceManager.primary_color
				ResourceManager.primary_color = new_color
		else: 
			if new_color != ResourceManager.primary_color:
				ResourceManager.secondary_color = new_color
			else:
				ResourceManager.primary_color = ResourceManager.secondary_color
				ResourceManager.secondary_color = new_color
		
		_set_icon_color()

func _enter_tree():
	%AnimationPlayer.play("appear")

func _on_settings_button_pressed():
	%AnimationPlayer.play("disappear")
	await %AnimationPlayer.animation_finished
	
	get_tree().change_scene_to_file(ResourceManager.last_scene)


func _on_p_color_button_pressed():
	%Label.text = "Primary"
	_is_peeking_primary = true
	_is_buttons_disabled = false
	
	%AnimationPlayer.play("open_color_peaker")

func _on_s_color_button_pressed():
	%Label.text = "Secondary"
	_is_peeking_primary = false
	_is_buttons_disabled = false
	
	%AnimationPlayer.play("open_color_peaker")


func _on_language_button_pressed():
	%AnimationPlayer.play("disappear")
	await %AnimationPlayer.animation_finished
	
	if ResourceManager.language == 'en':
		ResourceManager.language = 'ru'
	else:
		ResourceManager.language = 'en'
	
	%AnimationPlayer.play("appear")


func _on_lower_button_button_down():
	if ResourceManager.volume != 0:
		ResourceManager.volume -= 5
		_update_volume()
		$AudioStreamPlayer.play()

func _on_higher_button_button_down():
	if ResourceManager.volume != 100:
		ResourceManager.volume += 5
		_update_volume()
		$AudioStreamPlayer.play()
