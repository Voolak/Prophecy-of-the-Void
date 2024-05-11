extends RigidBody2D

@export var engine_power = 800
@export var spin_power = 10000

var thrust = Vector2.ZERO
var rotation_dir = 0

func get_input():
	thrust = Vector2.ZERO
	if Input.is_action_pressed("up"):
		thrust.y -= engine_power  # Move up
	if Input.is_action_pressed("down"):
		thrust.y += engine_power  # Move down
	if Input.is_action_pressed("left"):
		thrust.x -= engine_power  # Move left
	if Input.is_action_pressed("right"):
		thrust.x += engine_power  # Move right

func _physics_process(_delta):
	get_input()
	constant_force = thrust.rotated(rotation)  # Apply force in the direction of the ship
