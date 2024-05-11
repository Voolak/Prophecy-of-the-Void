extends CharacterBody2D

var SPEED = 400  # speed in pixels/sec
var ACCELERATION = 0

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED

	move_and_slide()
