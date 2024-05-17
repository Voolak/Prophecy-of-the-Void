class_name Powerup
extends Node2D

@onready var sprite_2d = $Sprite2D

@export_enum("Damage", "Penetration", "Movement Speed", "Bullet Rate", "Shield HP") var powerup_type : int

enum powerup_type_enum {DAMAGE, PENETRATION, MV_SPD, BULLET_RATE, SHIELD_HP}

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("powerup")
	
func set_parameters(position: Vector2, powerup: powerup_type_enum, texture: Texture):
	global_position = position
	powerup_type = powerup
	$Sprite2D.texture = texture
	

func powerup_player(player):
	match powerup_type:
		powerup_type_enum.DAMAGE:
			player.bullet_damage += 1
		powerup_type_enum.PENETRATION:
			player.bullet_hp += 1
		powerup_type_enum.MV_SPD:
			player.engine_power += 200
			player.rotation_speed += 1 
		powerup_type_enum.BULLET_RATE:
			var bulletrate = player.shooting_timer.wait_time() - 0.2
			player.set_shooting_timer_wait_time(bulletrate)
		powerup_type_enum.SHIELD_HP:
			player.bubble_hp += 1

func _on_hit_box_area_entered(player):
	powerup_player(player.get_parent().get_parent())
	GlobalSignals.emit_signal("PowerupTaken")
	GlobalSignals.emit_signal("Fighting")
	for powerup in get_tree().get_nodes_in_group("powerup"):
		powerup.queue_free()
