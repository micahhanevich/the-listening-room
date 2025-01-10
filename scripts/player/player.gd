extends CharacterBody3D


const SPEED = 10.0
const JUMP_VELOCITY = 30.0
const MAX_LOOK_ANGLE = PI/2
const STEP_HEIGHT = 10.0

var Speed_Multiplier = 1.0

# Keeps track of if the player has input movement since last frame
var moving: bool = false

var falling: bool = false

# Define player properties
@export_range(1, 10, 0.5)
var sensitivity: float = 5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var ClickTarget: Node3D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta * 10

	# Handle jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("move_sprint"):
		Speed_Multiplier = 1.8
	else:
		Speed_Multiplier = 1.0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED * Speed_Multiplier
		velocity.z = direction.z * SPEED * Speed_Multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * Speed_Multiplier)
		velocity.z = move_toward(velocity.z, 0, SPEED * Speed_Multiplier)
	
	velocity = velocity.rotated(Vector3.UP, %PlayerCamPivot.rotation.y)
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_toggle_cursor"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_released("ui_toggle_cursor"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if Input.is_action_just_pressed("pause"):
		if Game.PauseMenu.visible != true:
			get_tree().paused = true
			Game.PauseMenu.visible = true
			Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	
	if $PlayerCamPivot/PlayerCamera/RayCast3D.is_colliding():
		ClickTarget = $PlayerCamPivot/PlayerCamera/RayCast3D.get_collider()
	else:
		ClickTarget = null

# Called when an input is captured
func _input(event):
	if event is InputEventMouseMotion:
		var mouse_delta: Vector2 = event.relative
		
		# Rotate horizontally (around Y axis)
		%PlayerCamPivot.rotate_y(-mouse_delta.x * (sensitivity / 1000))
		
		# Rotate camera vertically
		%PlayerCamera.rotate_x(-mouse_delta.y * (sensitivity / 1000))
		%PlayerCamera.rotation.x = clamp(%PlayerCamera.rotation.x, -MAX_LOOK_ANGLE, MAX_LOOK_ANGLE)
	
	elif Input.is_action_just_pressed("select") && ClickTarget != null:
		ClickTarget.clicked_on.emit()
