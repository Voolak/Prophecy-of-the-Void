extends Node2D

class_name Enemy

@export var speed = 200
@export var hp = 1
@export var damage = 1
@export var push_force = 18000
@export var direction: Vector2 = Vector2.ZERO

@onready var screensize = get_viewport_rect().size
@onready var animation_player = $AnimationPlayer
@onready var indicator = $Indicator

var velocity = Vector2.ZERO
var canWarp = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies")

func set_parameters(position_param: Vector2, direction_param : Vector2):
	global_position = position_param
	direction = direction_param

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass

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

# on bullet enter
func _on_hit_box_area_entered(bullet):
	hp -= bullet.damage
	if hp <= 0:
		GlobalSignals.emit_signal("EnemyDies")
		animation_player.play("death")
