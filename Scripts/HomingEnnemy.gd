class_name HomingEnemy
extends Node2D

@export var speed = 200
@export var steer_force = 250.0

var velocity = Vector2.ZERO
@export var hp = 1
@onready var player = %Player

@onready var screensize = get_viewport_rect().size

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
	position.x = wrapf(position.x, 0, screensize.x)
	position.y = wrapf(position.y, 0, screensize.y)
	rotation = velocity.angle()


# on bullet enter
func _on_hit_box_area_entered(area):
	hp -= 1
	if hp <= 0:
		queue_free()
	area.queue_free()	#delete bullet
