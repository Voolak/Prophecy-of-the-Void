extends Node

@onready var timer = $Timer
@onready var player = %Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if player.hp == 0:
		#timer.start()
		#player.queue_free()
	
	#for enemy in get_tree().get_nodes_in_group("enemies"):
		#if enemy.hp <= 0:
			#enemy.queue_free()


func _on_timer_timeout():
	get_tree().reload_current_scene()
