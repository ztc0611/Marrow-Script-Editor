extends Node

func _ready():
	var a = DisplayServer.screen_get_size()
	if a.x <= 2000:
		get_tree().root.set_content_scale_factor(0.75)
