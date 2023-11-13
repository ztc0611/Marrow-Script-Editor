extends Panel

var current_ID = -1
var current_text = ""

var th = 236 #Text Box Height
@onready var mount = $MarginContainer/VBoxContainer
@onready var te = $MarginContainer/VBoxContainer/TextEdit
@onready var o = $MarginContainer/VBoxContainer/OptionButton
@onready var br_goto = $MarginContainer/VBoxContainer/Goto
@onready var choice_2 = [$MarginContainer/VBoxContainer/HBoxContainer, $MarginContainer/VBoxContainer/HBoxContainer2]

@onready var height_dict = {
	003: [th, te],
	100: [th, te],
	101: [th, te],
	102: [th, te],
	120: [th, te],
	121: [th, te],
	122: [th, te],
	140: [th, te],
	141: [th, te],
	142: [th, te],
	
	200: [112, br_goto],
	
	300: [190, choice_2]
}

func dump_data():
	if current_ID < 1:
		return []
	if current_ID == 300:
		return [current_ID, [[$MarginContainer/VBoxContainer/HBoxContainer/Label.text, $MarginContainer/VBoxContainer/HBoxContainer/OptionButton.selected], \
		[$MarginContainer/VBoxContainer/HBoxContainer2/Label.text, $MarginContainer/VBoxContainer/HBoxContainer2/OptionButton.selected]]]
	elif height_dict[current_ID][1] == te:
		return [current_ID, current_text]
	elif current_ID == 200:
		return [current_ID, br_goto.selected]
	else:
		return [current_ID, ""]

func _on_option_button_item_selected(index):
	index = o.get_selected_id()
	current_ID = index
	
	if index == 0:
		return
	
	resize(index)

func resize(index):
	if index == 003:
		$MarginContainer/VBoxContainer/TextEdit.placeholder_text = "Enter comment here. This will be completely ignored by the game."
	else:
		$MarginContainer/VBoxContainer/TextEdit.placeholder_text = "Me? Getting married and having a happy life would be OK, I guess..."
	#print(height_dict[index])
	self.custom_minimum_size.y = height_dict[index][0]
	if index < 300:
		height_dict[index][1].show()
	else:
		height_dict[index][1][0].show()
		height_dict[index][1][1].show()
	current_ID = index
	Global.set_undo()

func update_from_global(i):
	
	var int_i = int(i[0])
	if height_dict.has(int_i):
		#print(height_dict[int_i][1] == te)
		if int_i == 300:
			resize(int_i)
			i = i[1]
			choice_2[0].get_node("Label").text = i[0][0]
			choice_2[0].get_node("OptionButton").selected = i[0][1]
			choice_2[1].get_node("Label").text = i[1][0]
			choice_2[1].get_node("OptionButton").selected = i[1][1]
		elif int_i == 200:
			resize(int_i)
			br_goto.selected = int(i[1])
		elif height_dict[int_i][1] == te:
			resize(int_i)
			current_text = i[1]
			te.text = current_text
			
	o.selected = o.get_item_index(current_ID)

func _on_text_edit_focus_entered():
	Global.set_focused(true)

func _on_text_edit_focus_exited():
	Global.set_focused(false)

func _on_text_edit_text_changed():
	current_text = te.text
