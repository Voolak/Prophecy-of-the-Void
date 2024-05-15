extends RigidBody2D

@onready var screensize = get_viewport_rect().size
@onready var shooting_timer = $ShootingTimer
@onready var marker_2d = $CharacterSprite/Marker2D
@onready var character_sprite = $CharacterSprite
@onready var bubble_sprite = $BubbleSprite
@onready var animation_player = $AnimationPlayer

@export var engine_power = 800
@export var rotation_speed = 5.0
@export var Bullet : PackedScene
@export var hp = 1
@export var bubble_hp = 3

var SHOOT_THRUST = 25000
var thrust = Vector2.ZERO

var CRACK_STEP = 2.0/bubble_hp


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

	var current_angle = character_sprite.rotation
	var new_angle = lerp_angle(current_angle, target_angle, rotation_speed * _delta)
	character_sprite.rotation = new_angle
	
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
	var current_angle = character_sprite.rotation
	var thrust_angle = current_angle + PI
	var direction = Vector2(cos(thrust_angle), sin(thrust_angle))
	constant_force = SHOOT_THRUST * direction
	
	var b = Bullet.instantiate()
	owner.add_child(b)
	b.transform = marker_2d.global_transform

func _integrate_forces(state):
	var xform = state.transform
	xform.origin.x = wrapf(xform.origin.x, 0, screensize.x)
	xform.origin.y = wrapf(xform.origin.y, 0, screensize.y)
	state.transform = xform


func get_pushed(enemy):
	var push_direction = (global_position - enemy.global_position).normalized()
	apply_central_force(enemy.get_parent().push_force * push_direction)

func _on_hit_box_area_entered(enemy):
	hp -= 1
	get_pushed(enemy)
	if hp == 0 && bubble_hp == 0:
		animation_player.play("death")


func _on_bubble_hit_box_area_entered(enemy):
	bubble_hp -= 1
	var current_crack_intensity = bubble_sprite.material.get_shader_parameter("crack_intensity")
	print(CRACK_STEP)
	bubble_sprite.material.set_shader_parameter("crack_intensity", current_crack_intensity + CRACK_STEP)
	get_pushed(enemy)
	if bubble_hp == 0:
		bubble_sprite.queue_free()
