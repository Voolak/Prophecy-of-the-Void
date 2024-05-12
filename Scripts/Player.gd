extends RigidBody2D

@onready var screensize = get_viewport_rect().size
@onready var shooting_timer = $ShootingTimer

@export var engine_power = 800
@export var rotation_speed = 5.0

@export var Bullet : PackedScene

var SHOOT_THRUST = 25000

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
	
	# shoot
	if Input.is_action_pressed("shoot") && shooting_timer.is_stopped():
		shoot()
		shooting_timer.start()


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
		
func shoot():
	var current_angle = $Sprite2D.rotation
	var thrust_angle = current_angle + PI
	var direction = Vector2(cos(thrust_angle), sin(thrust_angle))
	constant_force = SHOOT_THRUST * direction
	
	var b = Bullet.instantiate()
	owner.add_child(b)
	b.transform = $Sprite2D/Marker2D.global_transform
	
func _integrate_forces(state):
	var xform = state.transform
	xform.origin.x = wrapf(xform.origin.x, 0, screensize.x)
	xform.origin.y = wrapf(xform.origin.y, 0, screensize.y)
	state.transform = xform
	


func _on_shooting_timer_timeout():
	pass # Replace with function body.
