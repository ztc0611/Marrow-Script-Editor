extends MenuBar

var new = Shortcut.new()
var save = Shortcut.new()
var load_recent = Shortcut.new()
var undo = Shortcut.new()
var redo = Shortcut.new()

var copy = Shortcut.new()
var paste = Shortcut.new()

func _ready():
	new.set_events(InputMap.action_get_events("ui_new"))
	save.set_events(InputMap.action_get_events("ui_save"))
	load_recent.set_events(InputMap.action_get_events("ui_load_recent"))
	
	undo.set_events(InputMap.action_get_events("ui_undo"))
	redo.set_events(InputMap.action_get_events("ui_redo"))
	
	copy.set_events(InputMap.action_get_events("ui_copy"))
	paste.set_events(InputMap.action_get_events("ui_paste"))
	
	$File.set_item_shortcut(0, new)
	$File.set_item_shortcut(2, save)
	$File.set_item_shortcut(4, load_recent)
	
	$Edit.set_item_shortcut(0, undo)
	$Edit.set_item_shortcut(1, redo)
	$Edit.set_item_shortcut(3, copy)
	$Edit.set_item_shortcut(4, paste)
	#print($Edit.get_item_shortcut(2))

func _on_edit_index_pressed(index):
	if index == 0:
		Global.get_undo()
		print("undo")
		print(Global.undo)
		print(Global.undo_loc)
	if index == 1:
		Global.redo()

func _on_file_index_pressed(index):
	if index == 0:
		Global.new_convo()
	if index == 2:
		Global.save()
	if index == 4:
		Global.load(true)
	if index == 6:
		print(OS.get_name())
		if "mac" in OS.get_name():
			print(ProjectSettings.globalize_path("user://"))
			OS.shell_open("file://"+ProjectSettings.globalize_path("user://"))
		else:
			OS.shell_open(ProjectSettings.globalize_path("user://"))

func _on_help_index_pressed(index):
	if index == 0:
		OS.shell_open("https://docs.google.com/spreadsheets/d/16wHT-VC1N0trv0zDz9DBKBtlvYSVGZuvEu6-syQeFy8/edit#gid=0")

func _process(delta):
	if Global.current == null or Global.undo_loc[Global.current] == 0:
		$Edit.set_item_disabled(0, true)
	else:
		$Edit.set_item_disabled(0, true) ## TODO: change back to false
	if Global.current == null or Global.undo_loc[Global.current] > Global.undo[Global.current].size():
		$Edit.set_item_disabled(1, true)
	else:
		$Edit.set_item_disabled(1, true) ## TODO: change back to false
	
	if Global.is_focused:
		$Edit.set_item_disabled(3, false)
		$Edit.set_item_disabled(4, false)
	else:
		$Edit.set_item_disabled(3, true)
		$Edit.set_item_disabled(4, true)
