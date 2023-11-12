extends VBoxContainer

func dump_tag_state():
	var dump = []
	for i in self.get_children():
		if not "Title" in i.name:
			dump.append_array(i.get_checked_tags())
	return dump

func set_tags_from_global(data):
	for i in self.get_children():
		if not "Title" in i.name:
			i.set_checked_tags(data)
