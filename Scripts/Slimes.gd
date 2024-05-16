extends Node2D

@export var speed: float = 200
@export var hp: int = 1
@export var direction: Vector2 = Vector2.ZERO

@onready var screensize = get_viewport_rect().size
@onready var animation_player = $AnimationPlayer

var velocity: Vector2 = Vector2.ZERO
	
func _ready():
	animation_player.play("scaling")
	velocity = direction.normalized()

func _physics_process(delta):
	velocity = velocity.normalized() * speed
	global_transform = global_transform.translated(velocity * delta)
	
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
	# Create two new slime instances
	var slime1 = duplicate()
	var slime2 = duplicate()

	var angle = direction.angle()
	var offset_angle = 75  # degrees
	var direction1 = Vector2.RIGHT.rotated(angle + offset_angle).normalized()
	var direction2 = Vector2.RIGHT.rotated(angle - offset_angle).normalized()

	slime1.direction = direction1
	slime2.direction = direction2

	get_parent().add_child(slime1)
	get_parent().add_child(slime2)

	queue_free()
