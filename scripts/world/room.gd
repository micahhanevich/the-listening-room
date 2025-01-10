extends Node3D

var PauseMenuScene: PackedScene = preload("res://scenes/ui/pause_menu.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	if find_child("PauseMenu", false) == null:
		add_child(PauseMenuScene.instantiate())
	print_debug(find_child("PauseMenu", false))
