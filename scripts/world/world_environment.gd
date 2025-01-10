extends WorldEnvironment


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.environment.sky_rotation.z += 0.00001
	self.environment.sky_rotation.y += 0.0002
