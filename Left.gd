extends Control

func build_sidebar(LI, a):
	for i in a:
		var l = LI.instantiate()
		var i_key = i
		l.set_name(str(i_key))
		l.set_text(i_key+": "+str(Global.data[i][0][1]))
		$ScrollContainer/VBoxContainer.add_child(l)
