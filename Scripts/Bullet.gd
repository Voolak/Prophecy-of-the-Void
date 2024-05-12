extends Area2D

var speed = 750

@onready var screensize = get_viewport_rect().size

func _physics_process(delta):
	position += transform.x * speed * delta
	position.x = wrapf(position.x, 0, screensize.x)
	position.y = wrapf(position.y, 0, screensize.y)

func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
