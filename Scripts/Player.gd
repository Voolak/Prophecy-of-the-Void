extends RigidBody2D

@export var engine_power = 800
@export var rotation_speed = 5.0

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
	#add_constant_force(thrust.rotated(rotation))

	var cursor_pos = get_global_mouse_position()
	var direction = (cursor_pos - global_position).normalized()

	var target_angle = direction.angle()

	var current_angle = $Sprite2D.rotation
	var new_angle = lerp_angle(current_angle, target_angle, rotation_speed * _delta)
	$Sprite2D.rotation = new_angle

func lerp_angle(a, b, t):
	var angle_diff = (b - a + PI) % (2 * PI) - PI
	return a + angle_diff * clamp(t, 0, 1)

func clamp(value, min, max):
	if value < min:
		return min
	elif value > max:
		return max
	else:
		return value
