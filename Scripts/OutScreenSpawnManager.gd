extends Path2D

@onready var screensize = get_viewport_rect().size
@onready var timer = $Timer
@onready var path_follow_2d = $PathFollow2D

#@export var Enemy : PackedScene
@export var enemies_left : int
@export var simultaneous_enemies : int
@export var enemy_list : Array[PackedScene] = []
@export var offset_spawn = 100

enum SIDE {TOP, RIGHT, BOTTOM, LEFT}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func random_position():
	var side = SIDE.values().pick_random()
	match side:
		SIDE.TOP:
			var rand_on_side = randi_range(0, screensize.x)
			return Vector2(rand_on_side, -offset_spawn)
		SIDE.RIGHT:
			var rand_on_side = randi_range(0, screensize.y)
			return Vector2(screensize.x + offset_spawn, rand_on_side)
		SIDE.BOTTOM:
			var rand_on_side = randi_range(0, screensize.x)
			return Vector2(rand_on_side, screensize.y + offset_spawn)
		SIDE.LEFT:
			var rand_on_side = randi_range(0, screensize.y)
			return Vector2(-offset_spawn, rand_on_side)

func _on_timer_timeout():
	for i in simultaneous_enemies:
		if enemies_left > 0:
			# instantiate enemies
			var enemy = enemy_list.pick_random().instantiate()
			owner.add_child(enemy)
			enemy.set_owner(owner)
			path_follow_2d.progress_ratio = randf()
			var enemy_position = path_follow_2d.global_position
			#var enemy_position = Vector2(screensize.x + 10, screensize.y + 10)
			var enemy_direction = Vector2(screensize.x/2 - enemy_position.x, \
										  screensize.y/2 - enemy_position.y)
			var offset_angle = randf_range(-PI/8, PI/8)  # degrees
			enemy_direction = Vector2.RIGHT.rotated(enemy_direction.angle() + offset_angle).normalized()
			enemy.set_parameters(enemy_position, enemy_direction)
			# decrease nb of enemies and disable timer if no more to spawn
			enemies_left -= 1
	
