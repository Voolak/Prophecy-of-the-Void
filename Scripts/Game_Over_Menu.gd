extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("RESET")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_retry_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/LevelModel.tscn")


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
