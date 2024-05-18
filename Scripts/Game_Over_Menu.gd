extends Control

@onready var wave = $Panel/Wave
@onready var best_wave = $Panel/BestWave


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("RESET")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_wave(wave_index):
	wave.text = "Wave : " + str(wave_index)
	best_wave.text = "Best wave : " + str(ScoreFile.best_wave)


func _on_retry_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/LevelModel.tscn")


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
