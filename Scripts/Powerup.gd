class_name Powerup
extends Node2D

@onready var sprite_2d = $Sprite2D

@export var texture_sprite: Texture
@export_enum("Damage", "Penetration", "Movement Speed") var powerup_type : int

enum powerup_type_enum {DAMAGE, PENETRATION, MV_SPD}

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("powerup")
	
func set_parameters(position: Vector2, powerup: powerup_type_enum, texture: Texture):
	global_position = position
	powerup_type = powerup
	texture_sprite = texture

func powerup_player(player):
	match powerup_type:
		powerup_type_enum.DAMAGE:
			player.bullet_damage += 1
		powerup_type_enum.PENETRATION:
			player.bullet_health += 1
		powerup_type_enum.MV_SPD:
			player.engine_speed += 200
			player.rotation_speed += 1 
	print(player.bullet_damage)

func _on_hit_box_area_entered(player):
	powerup_player(player.get_parent().get_parent())
	for powerup in get_tree().get_nodes_in_group("powerup"):
		powerup.queue_free()
