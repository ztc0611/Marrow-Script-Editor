extends Control

@onready var ListElement = preload("res://List_Element.tscn")
@export var buttonGroupDefault : ButtonGroup

var list_elements = []

func _ready():
	buttonGroupDefault = ButtonGroup.new()

func build_sidebar(a):
	for i in range(1, $ScrollContainer/VBoxContainer.get_children().size()):
		$ScrollContainer/VBoxContainer.get_children()[i].queue_free()
	list_elements = []
	for i in a:
		add_element(i)

func add_element(i):
	var l = ListElement.instantiate()
	var i_key = i
	l.set_name("Convo-"+str(i_key))
	l.set_text(i_key+": "+str(Global.get_text_preview(i_key)))#str(Global.data[i][0][1]))
	$ScrollContainer/VBoxContainer.add_child(l)
	$ScrollContainer/VBoxContainer.move_child(l,1)
	connect_buttons(l)
	list_elements.append(l)

func update_text_previews():
	print(list_elements)
	for i in list_elements:
		var i_key = i.get_id()
		i.set_text(i_key+": "+str(Global.get_text_preview(i_key)))

func connect_buttons(l):
	var button = l.get_child(1)
	button.button_group = buttonGroupDefault
	button.pressed.connect(_on_pressed.bind(l))

func _on_pressed(button):
	print(str("Button '", buttonGroupDefault.get_pressed_button().name, "' in the ButtonGroup has been pressed."))
	Global.set_current(button.get_id())

func _on_add_button_pressed():
	var a = Global.new_data()
	add_element(a)
