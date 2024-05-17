extends Node2D

@onready var screensize = get_viewport_rect().size
@onready var timer = $Timer
@onready var player = %Player
@onready var in_screen_spawn_manager = %InScreenSpawnManager
@onready var out_screen_spawn_manager = %OutScreenSpawnManager

@export var out_screen_spawns := 5
@export var in_screen_spawns := 5

enum powerup_type_enum {DAMAGE, PENETRATION, MV_SPD}
var wave_index = 1
var Powerup = preload("res://Scenes/Powerup.tscn")

#var powerup_sprite_1 = preload("res://Assets/Sprites/poussin.png")
var powerup_attack = preload("res://Assets/Sprites/Powerup/attaque.png")
var powerup_balles_cadence = preload("res://Assets/Sprites/Powerup/balles_cadence.png")
var powerup_hp_bouclier = preload("res://Assets/Sprites/Powerup/hp_bouclier.png")
var powerup_penetration = preload("res://Assets/Sprites/Powerup/penetration.png")
var powerup_vitesse = preload("res://Assets/Sprites/Powerup/vitesse.png")

var Slime_model = preload("res://Scenes/Slimes.tscn")
var is_game_over = false

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.connect("EnemyDies", handleenemydies)
	GlobalSignals.connect("PowerupTaken", handlepoweruptaken)
	GlobalSignals.connect("SlimeMultiply", handleslimemultiply)
	GlobalSignals.emit_signal("Fighting")

func handleenemydies():
	print("dies")
	print(get_tree().get_nodes_in_group("enemies").size())
	if out_screen_spawn_manager.enemies_left == 0 && in_screen_spawn_manager.enemies_left == 0 :
		# the last enemy is still in the process of dying
		if get_tree().get_nodes_in_group("enemies").size() == 1:
			GlobalSignals.emit_signal("PowerupsChoice")
			var powerup_pos_1 = Vector2(screensize.x/3, screensize.y/2)
			var powerup_pos_2 = Vector2(screensize.x/2, screensize.y/2)
			var powerup_pos_3 = Vector2(screensize.x*2/3, screensize.y/2)
			#spawn them
			spawn_powerup(powerup_pos_1, powerup_type_enum.DAMAGE, powerup_attack)
			spawn_powerup(powerup_pos_2, powerup_type_enum.PENETRATION, powerup_penetration)
			spawn_powerup(powerup_pos_3, powerup_type_enum.MV_SPD, powerup_vitesse)
			

func spawn_powerup(powerup_position: Vector2, powerup: powerup_type_enum, powerup_sprite: Texture):
	var new_powerup = Powerup.instantiate()
	new_powerup.set_parameters(powerup_position, powerup, powerup_sprite)
	owner.add_child(new_powerup)


func handlepoweruptaken():
	out_screen_spawns += 1
	in_screen_spawns += 1
	in_screen_spawn_manager.enemies_left = in_screen_spawns
	out_screen_spawn_manager.enemies_left = out_screen_spawns


func handleslimemultiply(slime_position, slime_angle):
	var slime1 = Slime_model.instantiate()
	var slime2 = Slime_model.instantiate()

	var offset_angle = 75  # degrees
	var direction1 = Vector2.RIGHT.rotated(slime_angle + offset_angle).normalized()
	var direction2 = Vector2.RIGHT.rotated(slime_angle - offset_angle).normalized()

	slime1.set_parameters(slime_position, direction1)
	slime2.set_parameters(slime_position, direction2)

	owner.add_child(slime1)
	owner.add_child(slime2)


func _on_player_death():
	is_game_over = true
	$"../CanvasLayer/GameOverMenu".visible = true
	$"../CanvasLayer/GameOverMenu/AnimationPlayer".play("blur")
