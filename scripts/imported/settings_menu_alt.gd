extends Control


var EnabledClose: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Game.SettingsMenu = self
	($TabContainer/Video/VBoxContainer/HBoxContainerOuter/HBoxContainerInner/OptionButton as OptionButton)\
	.selected = Game.ResolutionIndex
	$TabContainer/Video/VBoxContainer/HBoxContainerOuter/HBoxContainerInner2/CheckBox\
	.button_pressed = Game.Fullscreen
	$TabContainer/Video/VBoxContainer/HBoxContainerOuter2/HBoxContainerInner/CheckButton\
	.button_pressed = Game.VSync
	$TabContainer/Video/VBoxContainer/HBoxContainerOuter2/HBoxContainerInner2/CheckButton\
	.button_pressed = Game.Resizable
	$TabContainer/Audio/VBoxContainer/HBoxContainerOuter/HSlider\
	.set_value_no_signal(Game.Master_Volume)
	AudioServer.set_bus_volume_db(0, Game.Master_Volume)
	$TabContainer/Audio/VBoxContainer/HBoxContainerOuter2/HSlider\
	.set_value_no_signal(Game.Music_Volume)
	AudioServer.set_bus_volume_db(1, Game.Music_Volume)
	$TabContainer/Audio/VBoxContainer/HBoxContainerOuter3/HSlider\
	.set_value_no_signal(Game.Effect_Volume)
	AudioServer.set_bus_volume_db(2, Game.Effect_Volume)

func _exit_tree():
	Game.SettingsMenu = null

func _process(delta):
	if Input.is_action_just_pressed("ui_pause") && EnabledClose && Game.AllowPausing:
		_toggle_visibility()

func _toggle_visibility():
	visible = !visible
	EnabledClose = false
	get_tree().paused = !get_tree().paused
	$AudioStreamPlayer.play()

func _on_resume_press():
	_toggle_visibility()

func _load_main_menu():
	get_tree().paused = !get_tree().paused
	get_tree().change_scene_to_packed(Game.Scene_MainMenu)

func _on_quit_press():
	$AudioStreamPlayer.play()
	get_tree().quit()

func _on_resolution_selected(index):
	var res: Vector2i
	match index:
		0:
			res = Vector2i(640, 480)
		1:
			res = Vector2i(720, 480)
		2:
			res = Vector2i(800, 1200)
		3:
			res = Vector2i(1280, 720)
		4:
			res = Vector2i(1280, 1024)
		5:
			res = Vector2i(1280, 800)
		6:
			res = Vector2i(1360, 768)
		7:
			res = Vector2i(1366, 768)
		8:
			res = Vector2i(1440, 900)
		9:
			res = Vector2i(1600, 900)
		10:
			res = Vector2i(1680, 1050)
		11:
			res = Vector2i(1920, 1200)
		12:
			res = Vector2i(1920, 1080)
		13:
			res = Vector2i(2560, 1080)
		14:
			res = Vector2i(2560, 1600)
		15:
			res = Vector2i(2560, 1440)
		16:
			res = Vector2i(2880, 1800)
		17:
			res = Vector2i(3440, 1440)
		18:
			res = Vector2i(3840, 2160)
		19:
			res = Vector2i(5120, 1440)
	
	if get_window().get_mode() == Window.MODE_MAXIMIZED || get_window().get_mode() == Window.MODE_MINIMIZED:
		get_window().set_mode(Window.MODE_WINDOWED)
	
	Game.Resolution = [res[0],res[1]]
	Game.ResolutionIndex = index
	Game.ApplySettings()
	$AudioStreamPlayer.play()

func _on_fullscreen_toggled(toggled_on):
	Game.Fullscreen = toggled_on
	Game.ApplySettings()
	$AudioStreamPlayer.play()

func _on_vsync_toggled(toggled_on):
	Game.VSync = toggled_on
	Game.ApplySettings()
	$AudioStreamPlayer.play()

func _on_resizable_toggled(toggled_on):
	Game.Resizable = toggled_on
	Game.ApplySettings()
	$AudioStreamPlayer.play()

func _on_master_volume_slider_changed(value):
	Game.Master_Volume = value
	Game.ApplySettings()
	if value != -30:
		AudioServer.set_bus_volume_db(0, value)
		AudioServer.set_bus_mute(0, false)
	else:
		AudioServer.set_bus_mute(0, true)
	$AudioStreamPlayer.play()
	# $TabContainer/Audio/VBoxContainer/HBoxContainerOuter/PercentLabel.set_text(str(100) + "%")

func _on_music_volume_slider_changed(value):
	Game.Music_Volume = value
	Game.ApplySettings()
	if value != -30:
		AudioServer.set_bus_volume_db(1, value)
		AudioServer.set_bus_mute(1, false)
	else:
		AudioServer.set_bus_mute(1, true)
	$AudioStreamPlayer.play()

func _on_effect_volume_slider_changed(value):
	Game.Effect_Volume = value
	Game.ApplySettings()
	if value != -30:
		AudioServer.set_bus_volume_db(2, value)
		AudioServer.set_bus_mute(2, false)
	else:
		AudioServer.set_bus_mute(2, true)
	$AudioStreamPlayer.play()

func PlayButtonSound():
	$AudioStreamPlayer.play()
