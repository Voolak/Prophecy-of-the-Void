extends Node

@onready var fight_loop = $FightLoop
@onready var intro = $Intro
@onready var intro_loop = $IntroLoop
@onready var powerup_loop = $PowerupLoop

func _ready():
	GlobalSignals.connect("MainMenu", handlemainmenu)
	GlobalSignals.connect("Fighting", handlefighting)
	GlobalSignals.connect("PowerupsChoice", handlepowerupschoice)
	
func handlemainmenu():
	powerup_loop.stop()
	fight_loop.stop()
	intro.play()

func handlefighting():
	intro_loop.stop()
	intro.stop()
	powerup_loop.stop()
	fight_loop.play()

func handlepowerupschoice():
	intro.stop()
	intro_loop.stop()
	fight_loop.stop()
	powerup_loop.play()

func _on_intro_finished():
	intro_loop.play()
