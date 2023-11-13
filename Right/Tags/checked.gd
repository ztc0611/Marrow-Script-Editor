extends VBoxContainer

func get_checked_tags():
	var ret = []
	var a
	if "MarginContainer" in str(self.get_children()):
		a = self.get_node("MarginContainer/VBoxContainer")
	else:
		a = self
	for i in a.get_children():
		var b = i.is_checked()
		if b:
			ret.append(b)
	return ret

func reset_tags():
	var a
	if "MarginContainer" in str(self.get_children()):
		a = self.get_node("MarginContainer/VBoxContainer")
	else:
		a = self
	for i in a.get_children():
		i.disable_checks()

func set_checked_tags(data):
	var a
	if "MarginContainer" in str(self.get_children()):
		a = self.get_node("MarginContainer/VBoxContainer")
	else:
		a = self
	for i in a.get_children():
		i.set_checked(data)
