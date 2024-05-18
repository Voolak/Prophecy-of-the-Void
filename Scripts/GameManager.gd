extends Node2D

@onready var screensize = get_viewport_rect().size
@onready var timer = $Timer
@onready var player = %Player
@onready var in_screen_spawn_manager = %InScreenSpawnManager
@onready var out_screen_spawn_manager = %OutScreenSpawnManager
@onready var game_over_menu = $"../CanvasLayer/GameOverMenu"


var out_screen_spawns := 0
var in_screen_spawns := 0

enum powerup_type_enum {DAMAGE, PENETRATION, MV_SPD, BULLET_RATE, SHIELD_HP}
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

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	out_screen_spawns = out_screen_spawn_manager.enemies_left
	in_screen_spawns = in_screen_spawn_manager.enemies_left
	GlobalSignals.connect("EnemyDies", handleenemydies)
	GlobalSignals.connect("PowerupTaken", handlepoweruptaken)
	GlobalSignals.connect("SlimeMultiply", handleslimemultiply)
	GlobalSignals.emit_signal("Fighting")


func handleenemydies():
	var ra = randf()
	if out_screen_spawn_manager.enemies_left == 0 && in_screen_spawn_manager.enemies_left == 0 :
		# the last enemy is still in the process of dying
		if get_tree().get_nodes_in_group("enemies").size() <= 1:
			print("no more enemies " + str(ra))
			var random_powerup = powerup_type_enum.values().pick_random()
			var first_powerup = random_powerup
			while random_powerup == first_powerup:
				# The last fruit was picked, try again until we get a different fruit.
				random_powerup = powerup_type_enum.values().pick_random()
			
			GlobalSignals.emit_signal("PowerupsChoice")
			var powerup_pos_1 = Vector2(screensize.x/3, screensize.y/2)
			#var powerup_pos_2 = Vector2(screensize.x/2, screensize.y/2)
			var powerup_pos_2 = Vector2(screensize.x*2/3, screensize.y/2)
			#spawn them
			var first_sprite
			var second_sprite
			
			match first_powerup:
				powerup_type_enum.DAMAGE:
					first_sprite = powerup_attack
				powerup_type_enum.PENETRATION:
					first_sprite = powerup_penetration
				powerup_type_enum.MV_SPD:
					first_sprite = powerup_vitesse
				powerup_type_enum.BULLET_RATE:
					first_sprite = powerup_balles_cadence
				powerup_type_enum.SHIELD_HP:
					first_sprite = powerup_hp_bouclier
			match random_powerup:
				powerup_type_enum.DAMAGE:
					second_sprite = powerup_attack
				powerup_type_enum.PENETRATION:
					second_sprite = powerup_penetration
				powerup_type_enum.MV_SPD:
					second_sprite = powerup_vitesse
				powerup_type_enum.BULLET_RATE:
					second_sprite = powerup_balles_cadence
				powerup_type_enum.SHIELD_HP:
					second_sprite = powerup_hp_bouclier

			spawn_powerup(powerup_pos_1, first_powerup, first_sprite)
			#spawn_powerup(powerup_pos_2, powerup_type_enum.PENETRATION, powerup_penetration)
			spawn_powerup(powerup_pos_2, random_powerup, second_sprite)
			

func spawn_powerup(powerup_position: Vector2, powerup: powerup_type_enum, powerup_sprite: Texture):
	var new_powerup = Powerup.instantiate()
	new_powerup.set_parameters(powerup_position, powerup, powerup_sprite)
	owner.add_child(new_powerup)


func handlepoweruptaken():
	player.reset_shield()
	wave_index += 1
	out_screen_spawns += 1
	in_screen_spawns += 1
	in_screen_spawn_manager.enemies_left = in_screen_spawns
	out_screen_spawn_manager.enemies_left = out_screen_spawns
	if wave_index % 3 == 0:
		in_screen_spawn_manager.simultaneous_enemies += 1
		out_screen_spawn_manager.simultaneous_enemies += 1
	if ScoreFile.best_wave < wave_index:
		ScoreFile.best_wave = wave_index


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
	game_over_menu.set_wave(wave_index)
	$"../CanvasLayer/GameOverMenu".visible = true
	$"../CanvasLayer/GameOverMenu/AnimationPlayer".play("blur")
