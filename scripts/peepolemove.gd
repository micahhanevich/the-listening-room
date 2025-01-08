extends Node3D


# Juggle parameters
var amplitude = 0.9      # The height (amplitude) of the juggle
var frequency = 2.0      # How fast the juggle moves
var speed = .3        # The speed of the oscillation

# To track time for oscillation
var time_passed = 0.0

func _ready():
	# Initial setup when the object is ready
	pass

func _process(delta):
	# Update the time passed
	time_passed += delta * speed
	
	# Calculate the vertical movement using a sine wave for smooth oscillation
	var vertical_juggle = amplitude * sin(time_passed * frequency)
	
	# Apply the oscillation to the position of the 3D model (juggling effect)
	# This will oscillate the object vertically along the Y-axis
	scale.y = vertical_juggle + 3
	scale.x = vertical_juggle + 2
	scale.z = vertical_juggle + 6
	
	
