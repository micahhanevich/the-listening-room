extends SpotLight3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.light_energy = randf_range(6.5,8)
