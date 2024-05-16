extends CanvasLayer

@onready var parallax_background = $ParallaxBackground

func _process(delta):
	parallax_background.scroll_offset=DisplayServer.mouse_get_position()
