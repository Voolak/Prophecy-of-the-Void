extends Node2D

@export var speed = 200
@export var steer_force = 250.0
@export var hp = 1

var velocity = Vector2.ZERO
var canWarp = false

@onready var player = %Player
@onready var screensize = get_viewport_rect().size
@onready var animation_player = $AnimationPlayer
@onready var indicator = $indicator

func seek():
	var steer = Vector2.ZERO
	player = get_tree().get_first_node_in_group("player")
	if player:
		var desired = (player.global_position - global_position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer

func _physics_process(delta):
	var acceleration = seek()
	velocity += acceleration * delta
	velocity = velocity.normalized() * speed
	global_transform = global_transform.translated(velocity * delta)
	if canWarp :
		position.x = wrapf(position.x, 0, screensize.x)
		position.y = wrapf(position.y, 0, screensize.y)
	rotation = velocity.angle()
	# display the indicator if outside camera
	display_indicator()

# on bullet enter
func _on_hit_box_area_entered(area):
	hp -= 1
	if hp <= 0:
		$".".animation_player.play("death")
	area.queue_free()	#delete bullet
	
func enable_wrap():
	canWarp = true
	
# (0, 0) if in screen ; -1 if dim above or left ; 1 if dim below or right
func is_in_camera():
	return position.x >= 0 && position.x < screensize.x && \
		   position.y >= 0 && position.y < screensize.y
	
func display_indicator():
	if is_in_camera():
		indicator.visible = false
	else :
		indicator.visible = true
		indicator.global_position.x = clamp(global_position.x, 0, screensize.x)
		indicator.global_position.y = clamp(global_position.y, 0, screensize.y)
