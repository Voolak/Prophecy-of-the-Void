extends Area2D

@onready var timer = $Timer
@export var HIT_DAMAGE: int

func _on_body_entered(body):
	#timer.start()
	print("collision") 
	print(body.hp)


func _on_timer_timeout():
	get_tree().reload_current_scene()
