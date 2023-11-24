extends PopupMenu

func _on_id_pressed(id):
	if id == 0:
		Global.save()
