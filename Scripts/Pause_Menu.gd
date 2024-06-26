extends Control


func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")

func testEsc():
	if !%GameManager.is_game_over:
		if Input.is_action_just_pressed("pause") and !get_tree().paused:
			visible = !visible
			pause()
		elif Input.is_action_just_pressed("pause") and get_tree().paused:
			resume()
			visible = !visible


func _on_resume_pressed():
	resume()

func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()


func _process(delta):
	testEsc()


func _on_options_pressed():
	$OptionsMenu.visible = !$OptionsMenu.visible
	$Panel.visible = !$Panel.visible


func _on_main_menu_pressed():
	resume()
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
	
