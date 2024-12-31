extends Control


var CanUnpause: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause") && CanUnpause:
		close_menu()
	else:
		CanUnpause = true

func close_menu():
	set_visible(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false

func close_game():
	get_tree().quit()

func open_map_menu():
	add_sibling(preload("res://scenes/ui/map_menu.tscn").instantiate())
