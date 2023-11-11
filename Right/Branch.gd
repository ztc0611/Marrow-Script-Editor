extends VBoxContainer

var script_list = []

@onready var SE = preload("res://Right/ScriptElement.tscn")
@onready var AB = preload("res://Right/AddButton.tscn")

func set_title(t):
	$Title/Label.text = "Branch "+str(t)

func get_branch_dict():
	var ret = []
	for i in self.get_children():
		if "ScriptElement" in i.name or "Panel" in i.name:
			ret.append(i.dump_data())

func _ready():
	build_script_list()

func _process(delta):
	get_branch_dict()
	var next = false
	for i in self.get_children():
		if "ScriptElement" in i.name or "Panel" in i.name:
			if i.current_ID == 0:
				i.queue_free()
				script_list.remove_at(script_list.find(i))
				next = true
		if ("AddButton" in i.name or "MarginContainer" in i.name) and next:
			i.queue_free()
			script_list.remove_at(script_list.find(i))
			connect_buttons()
			return

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

func add_script_element(n):
	
	print(n)
	
	var se = SE.instantiate()
	add_child(se)
	self.move_child(se, n)
	script_list.insert(n, se)
	
	var ab = AB.instantiate()
	add_child(ab)
	self.move_child(ab, n)
	script_list.insert(n, ab)
	
	connect_buttons()
	
	print(script_list)
