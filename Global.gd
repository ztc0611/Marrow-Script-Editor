extends Node

var new_undo = {}
var undo = {}
var undo_loc = {}
var data = {}
var current = null
var current_data = null
var is_focused = false

@onready var ListElement = preload("res://List_Element.tscn")

func _ready():
	get_tree().get_root().get_node_or_null("Control/Program/Left").build_sidebar(ListElement, data)
	build_undo()

func build_undo():
	for i in data:
		undo[i] = []
		undo[i].append(data[i])
		undo_loc[i] = 0
		
	print(undo)
	print(current_data)

func set_focused(t):
	if !t:
		set_undo()
	is_focused = t

func purge_redo_tree():
	for i in range(undo_loc[current], undo[current].size()-1):
		undo[current].pop_back()

func get_undo():
	if undo_loc[current] > 0:
		undo_loc[current] -= 1

func redo():
	if undo_loc[current] < undo[current].size():
		undo_loc[current] += 1

func set_undo():
	
	print(undo[current].back())
	print(current_data)
	
	if !undo[current]:
		undo[current] = []
	
	if undo[current].back() != current_data:
		print("Not the same...")
		purge_redo_tree()
		undo[current].append(current_data)
		if undo[current].size() > 50:
			undo[current].pop_front()
	else:
		print("Arrays are the same.")

func save():
	var save_game = FileAccess.open("user://"+str(Time.get_unix_time_from_system())+".txt", FileAccess.WRITE)
	var json_string = JSON.stringify(data)
	save_game.store_line(json_string)
	
func _notification(what):
	if what == NOTIFICATION_WM_ABOUT:
		print("MarSEdit v1.0.0")
