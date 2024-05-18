extends Node2D

@onready var screensize = get_viewport_rect().size
@onready var timer = $Timer

@export var enemies_left : int
@export var simultaneous_enemies : int
@export var enemy_list : Array[PackedScene] = []
@export var spawnOffSet := 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	for i in simultaneous_enemies:
		if enemies_left > 0:
			var enemy = enemy_list.pick_random().instantiate()
			owner.add_child(enemy)
			enemy.set_owner(owner)
			enemy.global_position = Vector2(randi_range(0+spawnOffSet, screensize.x-spawnOffSet), \
											randi_range(0+spawnOffSet, screensize.y-spawnOffSet))
			enemies_left -= 1
	
		
