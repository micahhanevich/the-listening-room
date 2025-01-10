extends Control


func close_menu():
	set_visible(false)

func load_room():
	get_tree().paused = false
	get_tree().change_scene_to_packed(Game.Scene_Room)

func load_club():
	get_tree().paused = false
	get_tree().change_scene_to_packed(Game.Scene_Club)
