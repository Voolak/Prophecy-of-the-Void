extends Path2D

@onready var timer = $Timer
@onready var path_follow_2d = $PathFollow2D

@export var Enemy : PackedScene
@export var enemies_left : int
@export var simultaneous_enemies : int

enum enemy_type {HomingEnemy}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	for i in simultaneous_enemies:
		if enemies_left > 0:
			# instantiate enemies
			var enemy = Enemy.instantiate()
			enemy.add_to_group("enemies")
			owner.add_child(enemy)
			path_follow_2d.progress_ratio = randf()
			enemy.global_position = path_follow_2d.global_position
			# decrease nb of enemies and disable timer if no more to spawn
			enemies_left -= 1
	
