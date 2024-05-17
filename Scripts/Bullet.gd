extends Area2D

var speed = 750

@onready var screensize = get_viewport_rect().size
@onready var timer = $Timer

@export var hp : int
@export var damage : int
@onready var hurt_sound = $HurtSound1
@onready var hurt_sound_2 = $HurtSound2
@onready var hurt_sound_3 = $HurtSound3


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
	if !hurt_sound.playing:
		hurt_sound.play()
	elif !hurt_sound_2.playing:
		hurt_sound_2.play()
	elif !hurt_sound_3.playing:
		hurt_sound_3.play()
	if hp <= 0:
		queue_free()
