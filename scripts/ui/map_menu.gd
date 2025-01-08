extends Control


func close_all_menus():
	set_visible(false)
	$"..".close_menu()

func close_menu():
	set_visible(false)

func load_room():
	close_all_menus()
	get_tree().call_deferred("change_scene_to_packed", preload("res://scenes/room.tscn"))

func load_club():
	close_all_menus()
	get_tree().call_deferred("change_scene_to_packed", preload("res://scenes/club.tscn"))
