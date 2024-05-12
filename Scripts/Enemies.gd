extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in self.get_children():
		i.add_to_group("enemies")
