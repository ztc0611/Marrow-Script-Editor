extends MarginContainer

func set_text(n):
	$Button/MarginContainer/Label.text = n

func get_id():
	var n = str($Button/MarginContainer/Label.text)
	n = n.split(":")[0]
	return n
