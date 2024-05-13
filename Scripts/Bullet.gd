extends Area2D

var speed = 750

@onready var screensize = get_viewport_rect().size
@onready var timer = $Timer

func _ready():
	timer.start()

func _physics_process(delta):
	position += transform.x * speed * delta
	position.x = wrapf(position.x, 0, screensize.x)
	position.y = wrapf(position.y, 0, screensize.y)

func _on_timer_timeout():
	queue_free()

func _on_area_entered(area):
	pass
	#queue_free()
