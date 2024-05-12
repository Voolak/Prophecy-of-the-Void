extends Area2D

@export var speed = 200
@export var steer_force = 500.0

var velocity = Vector2.ZERO
var player = null

func _ready():
	player = get_node("../Player")

func seek():
	var steer = Vector2.ZERO
	if player:
		var desired = (player.global_position - global_position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer

func _physics_process(delta):
	var acceleration = seek()
	velocity += acceleration * delta
	velocity = velocity.normalized() * speed
	global_transform = global_transform.translated(velocity * delta)
	rotation = velocity.angle()

func _on_body_entered(body):
	queue_free()
