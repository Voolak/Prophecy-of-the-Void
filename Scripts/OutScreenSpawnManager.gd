extends Path2D

@onready var screensize = get_viewport_rect().size
@onready var timer = $Timer
@onready var path_follow_2d = $PathFollow2D

#@export var Enemy : PackedScene
@export var enemies_left : int
@export var simultaneous_enemies : int
@export var enemy_list : Array[PackedScene] = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	for i in simultaneous_enemies:
		if enemies_left > 0:
			# instantiate enemies
			var enemy = enemy_list.pick_random().instantiate()
			owner.add_child(enemy)
			enemy.set_owner(owner)
			path_follow_2d.progress_ratio = randf()
			var enemy_position = path_follow_2d.global_position
			var enemy_direction = Vector2(screensize.x/2 - enemy_position.x, \
										  screensize.y/2 - enemy_position.y)
			var offset_angle = randf_range(-PI/8, PI/8)  # degrees
			enemy_direction = Vector2.RIGHT.rotated(enemy_direction.angle() + offset_angle).normalized()
			enemy.set_parameters(path_follow_2d.global_position, enemy_direction)
			# decrease nb of enemies and disable timer if no more to spawn
			enemies_left -= 1
	
