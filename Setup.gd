extends Control

func _on_button_pressed():
	if $LineEdit.text.length() == 2:
		Global.set_writer_id($LineEdit.text)
		queue_free()
