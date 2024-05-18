extends Enemy

@onready var player = %Player

@export var simultaneous_enemies : int = 2
@export var enemy_list : Array[PackedScene] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies")
	set_process(false)
	animation_player.play("spawn_animation")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_spawn_timer_timeout():
	for i in simultaneous_enemies:
		var spawn = enemy_list.pick_random().instantiate()
		owner.add_child(spawn)
		var spawn_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))
		spawn.set_parameters(global_position, spawn_direction)
