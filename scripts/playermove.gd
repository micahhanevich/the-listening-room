extends Area3D

# Define player properties
@export_range(1, 20, 0.5)
var speed: float = 10

@export_range(1, 10, 0.5)
var sensitivity: float = 5

const max_look_angle = PI/2


# Called when the scene tree is ready
func _ready():
	# Lock the mouse cursor within the game window
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every physics frame
func _physics_process(delta):
	
	# Get player input for movement
	var direction = Vector3()
	
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
		
	if Input.is_action_pressed("move_backwards"):
		direction.z += 1
		
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
		
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	
	# Normalize and scale direction to speed and delta
	direction = direction.normalized() * speed * delta
	
	var t: Tween = create_tween()
	t.set_trans(Tween.TRANS_EXPO)
	t.tween_method(translate, Vector3.ZERO, direction, delta)
	
	if Input.is_action_just_pressed("pause"):
		get_tree().quit()

# Called when the mouse is moved
func _input(event):
	if event is InputEventMouseMotion:
		var mouse_delta: Vector2 = event.relative
		
		# Rotate horizontally (around Y axis)
		rotate_y(-mouse_delta.x * (sensitivity / 1000))
		
		# Rotate camera vertically
		%PlayerCamera.rotate_x(-mouse_delta.y * (sensitivity / 1000))
		%PlayerCamera.rotation.x = clamp(%PlayerCamera.rotation.x, -max_look_angle, max_look_angle)
