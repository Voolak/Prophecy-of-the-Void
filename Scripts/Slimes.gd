extends Node2D

@export var speed: float = 200
@export var hp: int = 1
@export var damage : int = 1
@export var push_force = 18000
@export var direction: Vector2 = Vector2.ZERO

@onready var screensize = get_viewport_rect().size
@onready var animation_player = $AnimationPlayer

var canWarp = false
var velocity: Vector2 = Vector2.ZERO
	
func _ready():
	animation_player.play("scaling")
	velocity = direction.normalized()
	
func set_parameters(position_param: Vector2, direction_param : Vector2):
	global_position = position_param
	direction = direction_param
	
func enable_wrap():
	canWarp = true

func _physics_process(delta):
	velocity = velocity.normalized() * speed
	global_transform = global_transform.translated(velocity * delta)
	
	if canWarp :
		position.x = wrapf(position.x, 0, screensize.x)
		position.y = wrapf(position.y, 0, screensize.y)
	
	rotation += 0.5 * delta

# on bullet enter
func _on_hit_box_area_entered(area):
	hp -= 1
	if hp <= 0:
		animation_player.play("death")
	area.queue_free()	#delete bullet

func multiply():
	GlobalSignals.emit_signal("SlimeMultiply", global_position, direction.angle())
	queue_free()
