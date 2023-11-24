extends TextureButton

var start_pos

func _process(delta):
	if self.button_pressed:
		DisplayServer.window_set_position(DisplayServer.mouse_get_position()-start_pos)

func _on_button_down():
	start_pos = DisplayServer.mouse_get_position()-DisplayServer.window_get_position()
