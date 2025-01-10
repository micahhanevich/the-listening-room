class_name Clickable extends Area3D


signal clicked_on

func _open_music_menu():
	Game.MusicMenu.set_visible(true)
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
