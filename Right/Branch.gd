extends VBoxContainer

var script_list = []
var title = ""

@onready var SE = preload("res://Right/ScriptElement.tscn")
@onready var AB = preload("res://Right/AddButton.tscn")

func set_title(t):
	title = "BRANCH-"+str(t)
	$Title/Label.text = "Branch "+str(t)

func get_branch_dict():
	var ret = []
	for i in self.get_children():
		if "ScriptElement" in i.name or "Panel" in i.name:
			ret.append(i.dump_data().duplicate(true))
	return ret

func build_branch_from_global(d):
	for i in range(2,self.get_children().size()):
		self.get_children()[i].queue_free()
	build_script_list()
	for i in d:
		var se = add_script_element(-1)
		if i.size() > 0:
			#print(i[0])
			se.update_from_global(i)
	set_process(true)

func _ready():
	pass
	set_process(false)

func _process(delta):
	for i in range(self.get_children().size()):
		var s = self.get_children()
		if "ScriptElement" in s[i].name or "Panel" in s[i].name:
			if s[i].current_ID == 0:
				s[i].queue_free()
				script_list.remove_at(script_list.find(s[i]))
				s[i+1].queue_free()
				script_list.remove_at(script_list.find(s[i+1]))
				connect_buttons()
				Global.set_undo()
	if Global.current:
		Global.current_data[title] = get_branch_dict().duplicate(true)

func build_script_list():
	script_list = []
	for i in self.get_children():
		if "Title" in i.name:
			script_list.append(i)
		elif "AddButton" in i.name or "MarginContainer" in i.name:
			script_list.append(i)
		elif "ScriptElement" in i.name or "Panel" in i.name:
			script_list.append(i)
	connect_buttons()

func connect_buttons():
	for i in self.get_children():
		if "AddButton" in i.name or "MarginContaine" in i.name:
			i.get_child(0).pressed.connect(_on_pressed.bind(i))

func _on_pressed(button):
	var a = script_list.find(button)
	add_script_element(a)
	Global.set_undo()

func add_script_element(n):
	
	var se = SE.instantiate()
	
	if n > 0:
	
		add_child(se)
		self.move_child(se, n)
		script_list.insert(n, se)
		
		var ab = AB.instantiate()
		add_child(ab)
		self.move_child(ab, n)
		script_list.insert(n, ab)
		
		connect_buttons()
	
	else:

		add_child(se)
		self.move_child(se, n)
		script_list.append(se)
		
		var ab = AB.instantiate()
		add_child(ab)
		self.move_child(ab, n)
		script_list.append(se)
		
		connect_buttons()
		
	
	return se
