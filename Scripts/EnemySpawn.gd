extends Path2D

@export var nb_enemies := 5
@onready var timer = $Timer
@onready var path_follow_2d = $PathFollow2D

@export var Enemy : PackedScene

enum enemy_type {HomingEnemy}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var enemy = Enemy.instantiate()
	enemy.add_to_group("enemies")
	owner.add_child(enemy)
	path_follow_2d.progress_ratio = randf()
	enemy.global_position = path_follow_2d.global_position
