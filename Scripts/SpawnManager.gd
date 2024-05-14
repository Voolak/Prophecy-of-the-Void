extends Node2D

@onready var screensize = get_viewport_rect().size
@onready var timer = $Timer

@export var enemies_left : int
@export var simultaneous_enemies : int
@export var Enemy : PackedScene
@export var spawnOffSet := 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	for i in simultaneous_enemies:
		if enemies_left > 0:
			var enemy = Enemy.instantiate()
			enemy.add_to_group("enemies")
			owner.add_child(enemy)
			enemy.global_position = Vector2(randi_range(0+spawnOffSet, screensize.x-spawnOffSet), \
											randi_range(0+spawnOffSet, screensize.y-spawnOffSet))
			enemies_left -= 1
	if enemies_left <= 0:
		timer.one_shot = true
		
