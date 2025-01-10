extends Control


var SubMenuOpen: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Game.PauseMenu = self

func _physics_process(delta):
	if Input.is_action_just_pressed("pause") && Game.CanUnpause && !SubMenuOpen:
		close_menu()
	elif Input.is_action_just_pressed("pause") && Game.CanUnpause && SubMenuOpen:
		close_sub_menus()
		SubMenuOpen = false
	else:
		Game.CanUnpause = true

func close_menu():
	set_visible(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	Game.CanUnpause = false
	$MapMenu.set_visible(false)
	$SettingsMenu.set_visible(false)

func close_sub_menus():
	$MapMenu.set_visible(false)
	$SettingsMenu.set_visible(false)

func close_game():
	get_tree().quit()

func open_map_menu():
	SubMenuOpen = true
	$MapMenu.set_visible(true)

func open_settings_menu():
	SubMenuOpen = true
	$SettingsMenu.set_visible(true)

func _exit_tree():
	Game.PauseMenu = null
