extends Area3D

# Define player properties
var speed = 5.0
var sensitivity = 0.005

var mouse_delta = Vector2()
var pitch_degrees = 0.0

# Define the maximum and minimum pitch angles (in degrees)
var max_pitch = 90
var min_pitch = -90


# Called when the scene tree is ready
func _ready():
	# Lock the mouse cursor within the game window
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame
func _process(delta):
	# Get player input for movement
	var direction = Vector3()
	if Input.is_action_pressed("move_forward"):
		direction += -global_transform.basis.z
	if Input.is_action_pressed("move_backwards"):
		direction += global_transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction += -global_transform.basis.x
	if Input.is_action_pressed("move_right"):
		direction += global_transform.basis.x

	# Move the player
	direction = direction.normalized() * speed * delta
	translate(direction)

# Called when the mouse is moved
func _input(event):
	if event is InputEventMouseMotion:
		mouse_delta = event.relative

		# Rotate horizontally (around Y axis)
		rotate_y(-mouse_delta.x * sensitivity)

		# Calculate the new pitch
		pitch_degrees += -mouse_delta.y * sensitivity
		pitch_degrees = clamp(pitch_degrees, min_pitch, max_pitch)

		# Apply the pitch rotation to the player
		rotation_degrees.x = pitch_degrees
