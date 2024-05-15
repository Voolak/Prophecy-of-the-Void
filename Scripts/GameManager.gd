extends Node

@onready var timer = $Timer
@onready var player = %Player
@onready var enemy_spawn = %EnemySpawn
@onready var in_screen_spawn_manager = %InScreenSpawnManager

var wave_index = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.connect("EnemyDies", handleenemydies)


func handleenemydies():
	if enemy_spawn.enemies_left == 0 && in_screen_spawn_manager.enemies_left == 0 :
		# the last enemy is still in the process of dying
		if get_tree().get_nodes_in_group("enemies").size() == 1:
			print("jokes over ! you dead !")
