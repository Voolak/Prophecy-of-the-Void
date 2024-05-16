extends Enemy

signal enemydies

@export var steer_force = 250.0

@onready var player = %Player

func _ready():
	add_to_group("enemies")

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



