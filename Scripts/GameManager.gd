extends Node2D

@onready var screensize = get_viewport_rect().size
@onready var timer = $Timer
@onready var player = %Player
@onready var enemy_spawn = %EnemySpawn
@onready var in_screen_spawn_manager = %InScreenSpawnManager

@export var out_screen_spawns := 5
@export var in_screen_spawns := 5

enum powerup_type_enum {DAMAGE, PENETRATION, MV_SPD}
var wave_index = 1
var Powerup = preload("res://Scenes/Powerup.tscn")
var powerup_sprite_1 = preload("res://Assets/Sprites/poussin.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.connect("EnemyDies", handleenemydies)
	GlobalSignals.connect("PowerupTaken", handlepoweruptaken)

func handleenemydies():
	if enemy_spawn.enemies_left == 0 && in_screen_spawn_manager.enemies_left == 0 :
		# the last enemy is still in the process of dying
		if get_tree().get_nodes_in_group("enemies").size() == 1:
			var powerup_pos_1 = Vector2(screensize.x/3, screensize.y/2)
			var powerup_pos_2 = Vector2(screensize.x/2, screensize.y/2)
			var powerup_pos_3 = Vector2(screensize.x*2/3, screensize.y/2)
			#spawn them
			spawn_powerup(powerup_pos_1, powerup_type_enum.DAMAGE, powerup_sprite_1)
			spawn_powerup(powerup_pos_2, powerup_type_enum.PENETRATION, powerup_sprite_1)
			spawn_powerup(powerup_pos_3, powerup_type_enum.MV_SPD, powerup_sprite_1)
			

func spawn_powerup(powerup_position: Vector2, powerup: powerup_type_enum, powerup_sprite: Texture):
	var new_powerup = Powerup.instantiate()
	new_powerup.set_parameters(powerup_position, powerup, powerup_sprite)
	owner.add_child(new_powerup)


func handlepoweruptaken():
	out_screen_spawns += 1
	in_screen_spawns += 1
	in_screen_spawn_manager.enemies_left = in_screen_spawns
	enemy_spawn.enemies_left = out_screen_spawns 
