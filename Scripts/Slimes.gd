extends Enemy
	
func _ready():
	add_to_group("enemies")
	animation_player.play("scaling")
	velocity = direction.normalized()

func set_parameters(position_param: Vector2, direction_param : Vector2):
	global_position = position_param
	direction = direction_param
	velocity = direction

func _physics_process(delta):
	velocity = velocity.normalized() * speed
	global_transform = global_transform.translated(velocity * delta)
	if canWarp :
		position.x = wrapf(position.x, 0, screensize.x)
		position.y = wrapf(position.y, 0, screensize.y)
	rotation += 0.5 * delta

func multiply():
	GlobalSignals.emit_signal("SlimeMultiply", global_position, direction.angle())
	queue_free()
