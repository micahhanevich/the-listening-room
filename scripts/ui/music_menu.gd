extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Game.MusicMenu = self

func CloseMenu():
	self.set_visible(false)
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
