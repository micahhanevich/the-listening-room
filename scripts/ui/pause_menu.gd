extends Control


var CanUnpause: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_just_pressed("pause") && CanUnpause:
		close_menu()
	else:
		CanUnpause = true

func close_menu():
	set_visible(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	CanUnpause = false
	$MapMenu.set_visible(false)

func close_game():
	get_tree().quit()

func open_map_menu():
	$MapMenu.set_visible(true)
