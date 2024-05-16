extends Control

func _ready():
	get_viewport().size = DisplayServer.screen_get_size()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/LevelModel.tscn")


func _on_options_pressed():
	$OptionsMenu.visible = !$OptionsMenu.visible
	$MarginContainer.visible = !$MarginContainer.visible
	#get_tree().change_scene_to_file("res://scenes/Options_Menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
