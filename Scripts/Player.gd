extends RigidBody2D

@export var engine_power = 800

var thrust = Vector2.ZERO

func get_input():
	thrust = Vector2.ZERO
	if Input.is_action_pressed("up"):
		thrust.y -= engine_power
	if Input.is_action_pressed("down"):
		thrust.y += engine_power
	if Input.is_action_pressed("left"):
		thrust.x -= engine_power
	if Input.is_action_pressed("right"):
		thrust.x += engine_power

func _physics_process(_delta):
	get_input()
	constant_force = thrust.rotated(rotation)
	
	var cursor_pos = get_global_mouse_position()
	var direction = (cursor_pos - global_position).normalized()

	var angle = direction.angle()

	$Sprite2D.rotation = angle
