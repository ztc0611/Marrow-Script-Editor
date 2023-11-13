extends Node

func _ready():
	var a = DisplayServer.screen_get_size()
	if a.x <= 2000:
		ProjectSettings.set_setting("display/window/stretch/scale",0.75)
		ProjectSettings.save_custom("override.cfg")

