extends MenuBar

var save = Shortcut.new()
var undo = Shortcut.new()
var redo = Shortcut.new()

var copy = Shortcut.new()
var paste = Shortcut.new()

func _ready():
	save.set_events(InputMap.action_get_events("ui_save"))
	undo.set_events(InputMap.action_get_events("ui_undo"))
	redo.set_events(InputMap.action_get_events("ui_redo"))
	
	copy.set_events(InputMap.action_get_events("ui_copy"))
	paste.set_events(InputMap.action_get_events("ui_paste"))
	
	$File.set_item_shortcut(0, save)
	$Edit.set_item_shortcut(0, undo)
	$Edit.set_item_shortcut(1, redo)
	$Edit.set_item_shortcut(3, copy)
	$Edit.set_item_shortcut(4, paste)
	#print($Edit.get_item_shortcut(2))

func _on_edit_index_pressed(index):
	if index == 0:
		print("undo")
	if index == 1:
		print("redo")

func _on_file_index_pressed(index):
	if index == 0:
		Global.save()

func _process(delta):
	if Global.current == null or Global.undo_loc[Global.current] == 0:
		$Edit.set_item_disabled(0,true)
	else:
		$Edit.set_item_disabled(0,false)
	if Global.current == null or Global.undo_loc[Global.current] >= Global.undo[Global.current].size():
		$Edit.set_item_disabled(1, true)
	else:
		$Edit.set_item_disabled(1, false)
	
	if Global.is_focused:
		$Edit.set_item_disabled(3, false)
		$Edit.set_item_disabled(4, false)
	else:
		$Edit.set_item_disabled(3, true)
		$Edit.set_item_disabled(4, true)
