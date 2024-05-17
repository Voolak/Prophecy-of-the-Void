extends Area2D

var speed = 750

@onready var screensize = get_viewport_rect().size
@onready var timer = $Timer

@export var hp : int
@export var damage : int


func _ready():
	timer.start()

# use when instantiate : Bullet.instantiate().with_parameters(...)
func set_parameters(hp_param: int, damage_param: int):
	hp = hp_param
	damage = damage_param

func _physics_process(delta):
	position += transform.x * speed * delta
	position.x = wrapf(position.x, 0, screensize.x)
	position.y = wrapf(position.y, 0, screensize.y)

func _on_timer_timeout():
	queue_free()

func _on_area_entered(enemy):
	hp -= 1
	if hp <= 0:
		queue_free()
