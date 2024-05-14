extends Node2D

@export var speed = 200
@export var hp = 1

var velocity = Vector2.LEFT
var direction = randi() % 4

@onready var player = %Player
@onready var screensize = get_viewport_rect().size
@onready var animation_player = $AnimationPlayer
@onready var scaling_timer = $ScalingTimer

func _ready():
	animation_player.play("scaling")
	

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
		$".".animation_player.play("death")
	area.queue_free()	#delete bullet

func _multiply(){
	
}

func _on_scaling_timer_timeout():
	pass # Replace with function body.
