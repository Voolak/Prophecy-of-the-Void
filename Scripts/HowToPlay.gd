extends Control

@onready var margin_container = $"../MarginContainer"
@onready var panel = $"../Panel"

func _on_back_pressed():
	$".".visible = false
	if margin_container:
		margin_container.visible = true
	elif panel:
		panel.visible = true
