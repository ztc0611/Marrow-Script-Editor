extends Control

@onready var mount = $ScrollContainer/MarginContainer/HBoxContainer
@onready var mount2 = $ScrollContainer2/MarginContainer/TagList
@onready var RB = preload("res://Right/Branch.tscn")

func _ready():
	for i in range(10):
		var b = RB.instantiate()
		b.set_title(Global.alphabet[i])
		mount.add_child(b)

func _process(_delta):
	if Global.current == null:
		self.hide()
	else:
		self.show()

func save():
	if Global.current:
		Global.current_data["TAGS"] = mount2.dump_tag_state()

func rebuild_branches(data):
	
	#print("       ",data)
	mount2.reset_tags()
	if data["TAGS"].size() > 0:
		mount2.set_tags_from_global(data["TAGS"])
	
	for i in range(mount.get_children().size()):
		mount.get_children()[i].build_branch_from_global((data["BRANCH-"+Global.alphabet[i]]))
