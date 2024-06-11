extends Area3D


func on_area_entered():
	%Player.OnGround = true

func on_area_exited():
	%Player.OnGround = false
