extends Label

func _process(delta):
	if Global.current:
		self.text = str(Global.undo_loc[Global.current])
