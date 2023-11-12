extends Node

var writer_id = ""

var undo = {}
var undo_loc = {}
#var data = {"zc-0001":[[100, "Hello"]],"zc-0002":[[100, "Hello"]]}
var data = {}
var current = null
var current_data = null
var is_focused = false

const autosave_frq = 60*1
@onready var autosave = autosave_frq

func _ready():
	find_id()

func find_id():
	var guy = FileAccess.open("user://id.txt", FileAccess.READ)
	if guy:
		writer_id = guy.get_line()
	else:
		get_tree().get_root().get_node_or_null("Control/Setup").show()

func set_writer_id(a):
	a = a.to_upper()
	var guy = FileAccess.open("user://id.txt", FileAccess.WRITE)
	guy.store_line(a)
	writer_id = a

func new_data():
	var max = 0
	var a
	var b: int
	for i in data.keys():
		a = str(i)
		a = a.split("-")
		b = int(a[1])
		if b > max:
			max = b
	max += 1
	var new_key = writer_id+"-"+("%04d")%max
	
	data[new_key] = {}
	build_branches(data[new_key])
	undo_loc[new_key] = 0
	undo[new_key] = []
	
	return new_key

var alphabet = ['A','B','C','D','E','F','G','H','I','J']
func build_branches(d):
	for i in alphabet:
		d["BRANCH-"+i] = []
	d["MSE_VER"] = Version.version
	d["TAGS"] = []
	print(d)

func get_text_preview(index):
	if !data.has(index) or data[index]["BRANCH-A"].size() < 1 or data[index]["BRANCH-A"][0].size() < 1:
		return ""
	else:
		return data[index]["BRANCH-A"][0][1]

func set_current(l):
	if current == l:
		return
	if current:
		get_tree().get_root().get_node_or_null("Control/Program/Right").save()
		data[current] = current_data.duplicate(true)
	current = l
	current_data = data[l].duplicate(true)
	if current:
		set_focused(false)
	var il = int(l)
	#print(data[l])
	get_tree().get_root().get_node_or_null("Control/Program/Left").update_text_previews()
	get_tree().get_root().get_node_or_null("Control/Program/Right").rebuild_branches(current_data)

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

## TODO: Repair Undo/Redo functionality

func get_undo():
	if undo_loc[current] > 0:
		undo_loc[current] -= 1
	current_data = undo[current][undo_loc[current]].duplicate(true)
	get_tree().get_root().get_node_or_null("Control/Program/Right").rebuild_branches(current_data)

func set_undo():
	
	print(undo[current].back())
	print(current_data)
	
	if !undo[current]:
		undo[current] = []
	
	if undo[current].back() != current_data:
		print("Not the same...")
		purge_redo_tree()
		undo[current].append(current_data.duplicate(true))
		undo_loc[current] += 1
		#if undo[current].size() > 50:
			#undo[current].pop_front()
	else:
		print("Arrays are the same.")

func purge_redo_tree():
	for i in range(undo_loc[current]+1, undo[current].size()):
		undo[current].pop_back()
	
	if undo_loc[current] > undo[current].size():
		undo_loc[current] = undo[current].size()

func redo():
	if undo_loc[current] < undo[current].size()-1:
		undo_loc[current] += 1
	else:
		return
	print(current_data)
	print(undo)
	current_data = undo[current][undo_loc[current]].duplicate(true)
	get_tree().get_root().get_node_or_null("Control/Program/Right").rebuild_branches(current_data)

func _process(delta):
	autosave-= delta
	if autosave < 0:
		autosave = autosave_frq
		save(true)

func load(recent=false):
	
	var to_load
	
	if recent:
		var dir = DirAccess.open("user://")
		var unix = []
		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()
			while file_name != "":
				if !dir.current_is_dir():
					print("Found directory: " + file_name)
					unix.append(file_name)
				file_name = dir.get_next()
		
		var max = 0
		for i in unix:
			var a = Time.get_unix_time_from_datetime_string(i)
			if a > max:
				max = a
		print(max)
		max = Time.get_datetime_string_from_unix_time(max)
		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()
			while file_name != "":
				if !dir.current_is_dir():
					if max in file_name:
						to_load = file_name
						#to_load = to_load.replace(":","/")
				file_name = dir.get_next()
	
	var f = FileAccess.open("user://"+to_load, FileAccess.READ)
	print("user://"+to_load)
	var json = JSON.new()
	print(f)
	data = json.parse_string(f.get_line())

	print(data["ZC-0001"]["BRANCH-A"][0][0])
	print(typeof(data["ZC-0001"]["BRANCH-A"][0][0]))
	
	print(data)
	
	get_tree().get_root().get_node_or_null("Control/Program/Left").build_sidebar(data)
	build_undo()

func save(auto=false):
	
	data[current] = current_data
	
	if !Global.current:
		return
	
	get_tree().get_root().get_node_or_null("Control/Program/Right").save()
	
	var dir = "user://"+str(Time.get_datetime_string_from_system())
	if auto:
		dir += "-AUTO"
	dir += ".txt"
	
	var save_game = FileAccess.open(dir, FileAccess.WRITE)
	var json_string = JSON.stringify(data)
	save_game.store_line(json_string)
	
func _notification(what):
	if what == NOTIFICATION_WM_ABOUT:
		print("MarSEdit v1.0.0")
