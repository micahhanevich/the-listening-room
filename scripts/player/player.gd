extends CharacterBody3D


const SPEED = 9.0
const JUMP_VELOCITY = 12.0
const MAX_LOOK_ANGLE = PI/2

# Define player properties
@export_range(1, 10, 0.5)
var sensitivity: float = 5


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta * 3

	# Handle jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	velocity = velocity.rotated(Vector3.UP, %PlayerCamPivot.rotation.y)
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_toggle_cursor"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_released("ui_toggle_cursor"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if Input.is_action_just_pressed("pause"):
		get_tree().quit.call_deferred()

# Called when the mouse is moved
func _input(event):
	if event is InputEventMouseMotion:
		var mouse_delta: Vector2 = event.relative
		
		# Rotate horizontally (around Y axis)
		%PlayerCamPivot.rotate_y(-mouse_delta.x * (sensitivity / 1000))
		
		# Rotate camera vertically
		%PlayerCamera.rotate_x(-mouse_delta.y * (sensitivity / 1000))
		%PlayerCamera.rotation.x = clamp(%PlayerCamera.rotation.x, -MAX_LOOK_ANGLE, MAX_LOOK_ANGLE)
