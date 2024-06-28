extends Control

@export var action_items: Array[String]

@onready var margin_container = $MarginContainer
@onready var panel = $MarginContainer/Panel

@onready var settings_grid_container = %SettingsGridContainer
@onready var back = %Back

#func _ready():
	#create_action_remap_items()
#
#func _on_back_pressed():
	#visible = false

	#if margin_container:
		#margin_container.visible = true
	#elif panel:
		#panel.visible = true

#func create_action_remap_items() -> void:
	#var previous_item = settings_grid_container.get_child(settings_grid_container.get_child_count() - 1)
	#for index in range(action_items.size()):
		#var action = action_items[index]
		#var label = Label.new()
		#label.text = action
		#settings_grid_container.add_child(label)
		#
		#var button = RemapButton.new()
		#button.action = action
		#button.focus_neighbor_top = previous_item.get_path()
		#previous_item.focus_neighbor_bottom = button.get_path()
		#if index == action_items.size() - 1:
			#back.focus_neighbor_top = button.get_path()
			#button.focus_neighbor_bottom = back.get_path()
		#previous_item = button
		#settings_grid_container.add_child(button)

func _on_full_screen_toggle_toggled(toggled_on):
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		var size = get_viewport().size
		DisplayServer.window_set_size(size)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
