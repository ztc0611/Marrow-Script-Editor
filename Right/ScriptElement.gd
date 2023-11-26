extends Panel

var current_ID = -1
var current_text = ""

var th = 236 #Text Box Height
@onready var mount = $MarginContainer/VBoxContainer
@onready var te = $MarginContainer/VBoxContainer/TextEdit
@onready var o = $MarginContainer/VBoxContainer/OptionButton
@onready var br_goto = $MarginContainer/VBoxContainer/Goto

@onready var choice_all = [$MarginContainer/VBoxContainer/HBoxContainer, $MarginContainer/VBoxContainer/HBoxContainer2, $MarginContainer/VBoxContainer/HBoxContainer3, $MarginContainer/VBoxContainer/HBoxContainer4, $MarginContainer/VBoxContainer/HBoxContainer5]
@onready var choice_2 = choice_all.slice(0,2)
@onready var choice_3 = choice_all.slice(0,3)
@onready var choice_4 = choice_all.slice(0,4)
@onready var choice_5 = choice_all

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
	
	300: [190, choice_2],
	301: [260, choice_3],
	302: [320, choice_4],
	303: [390, choice_5],
	
	310: [260, choice_3],
	311: [390, choice_5],
}

func dump_data():
	if current_ID < 1:
		return []
	if height_dict[current_ID][1] == choice_2:
		return [current_ID, [[$MarginContainer/VBoxContainer/HBoxContainer/Label.text, $MarginContainer/VBoxContainer/HBoxContainer/OptionButton.selected], \
		[$MarginContainer/VBoxContainer/HBoxContainer2/Label.text, $MarginContainer/VBoxContainer/HBoxContainer2/OptionButton.selected]]]
	elif height_dict[current_ID][1] == choice_3:
		return [current_ID, [[$MarginContainer/VBoxContainer/HBoxContainer/Label.text, $MarginContainer/VBoxContainer/HBoxContainer/OptionButton.selected], \
		[$MarginContainer/VBoxContainer/HBoxContainer2/Label.text, $MarginContainer/VBoxContainer/HBoxContainer2/OptionButton.selected], \
		[$MarginContainer/VBoxContainer/HBoxContainer3/Label.text, $MarginContainer/VBoxContainer/HBoxContainer3/OptionButton.selected]]]
	elif height_dict[current_ID][1] == choice_4:
		return [current_ID, [[$MarginContainer/VBoxContainer/HBoxContainer/Label.text, $MarginContainer/VBoxContainer/HBoxContainer/OptionButton.selected], \
		[$MarginContainer/VBoxContainer/HBoxContainer2/Label.text, $MarginContainer/VBoxContainer/HBoxContainer2/OptionButton.selected], \
		[$MarginContainer/VBoxContainer/HBoxContainer3/Label.text, $MarginContainer/VBoxContainer/HBoxContainer3/OptionButton.selected], \
		[$MarginContainer/VBoxContainer/HBoxContainer4/Label.text, $MarginContainer/VBoxContainer/HBoxContainer4/OptionButton.selected] ]]
	elif height_dict[current_ID][1] == choice_5:
		return [current_ID, [[$MarginContainer/VBoxContainer/HBoxContainer/Label.text, $MarginContainer/VBoxContainer/HBoxContainer/OptionButton.selected], \
		[$MarginContainer/VBoxContainer/HBoxContainer2/Label.text, $MarginContainer/VBoxContainer/HBoxContainer2/OptionButton.selected], \
		[$MarginContainer/VBoxContainer/HBoxContainer3/Label.text, $MarginContainer/VBoxContainer/HBoxContainer3/OptionButton.selected], \
		[$MarginContainer/VBoxContainer/HBoxContainer4/Label.text, $MarginContainer/VBoxContainer/HBoxContainer4/OptionButton.selected], \
		[$MarginContainer/VBoxContainer/HBoxContainer5/Label.text, $MarginContainer/VBoxContainer/HBoxContainer5/OptionButton.selected] ]]
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
	
	for i in choice_all:
		i.hide()
		i.get_child(0).editable = true
	
	## Modify small elements
	if index == 003:
		$MarginContainer/VBoxContainer/TextEdit.placeholder_text = "Enter comment here. This will be completely ignored by the game."
	else:
		$MarginContainer/VBoxContainer/TextEdit.placeholder_text = "Me? Getting married and having a happy life would be OK, I guess..."
	if index == 310:
		choice_all[0].get_child(0).placeholder_text = "Top"
		choice_all[1].get_child(0).placeholder_text = ""
		choice_all[2].get_child(0).placeholder_text = "Bottom"
	elif index == 311:
		choice_all[0].get_child(0).placeholder_text = "Top"
		choice_all[1].get_child(0).placeholder_text = ""
		choice_all[2].get_child(0).placeholder_text = ""
		choice_all[3].get_child(0).placeholder_text = ""
		choice_all[4].get_child(0).placeholder_text = "Bottom"
	else:
		choice_all[0].get_child(0).placeholder_text = "Option 1"
		choice_all[1].get_child(0).placeholder_text = "Option 2"
		choice_all[2].get_child(0).placeholder_text = "Option 3"
		choice_all[3].get_child(0).placeholder_text = "Option 4"
		choice_all[4].get_child(0).placeholder_text = "Option 5"

	self.custom_minimum_size.y = height_dict[index][0]
	if index < 300:
		height_dict[index][1].show()
	elif height_dict[index][1] == choice_2:
		height_dict[index][1][0].show()
		height_dict[index][1][1].show()
	elif height_dict[index][1] == choice_3:
		if index == 310:
			height_dict[index][1][1].get_child(0).editable = false
		height_dict[index][1][0].show()
		height_dict[index][1][1].show()
		height_dict[index][1][2].show()
	elif height_dict[index][1] == choice_4:
		height_dict[index][1][0].show()
		height_dict[index][1][1].show()
		height_dict[index][1][2].show()
		height_dict[index][1][3].show()
	elif height_dict[index][1] == choice_5:
		if index == 311:
			height_dict[index][1][1].get_child(0).editable = false
			height_dict[index][1][2].get_child(0).editable = false
			height_dict[index][1][3].get_child(0).editable = false
		height_dict[index][1][0].show()
		height_dict[index][1][1].show()
		height_dict[index][1][2].show()
		height_dict[index][1][3].show()
		height_dict[index][1][4].show()
	current_ID = index
	Global.set_undo()

func update_from_global(i):
	
	var int_i = int(i[0])
	if height_dict.has(int_i):
		print("  ", int_i)
		print("    ",height_dict[int_i])
		print("       ",height_dict[int_i][1])
		if height_dict[int_i][1] == choice_2: ## TODO: I know this can be cleaned up as its mostly copy pasted code but I cant think of how to right now.
			resize(int_i)
			i = i[1]
			choice_2[0].get_node("Label").text = i[0][0]
			choice_2[0].get_node("OptionButton").selected = i[0][1]
			choice_2[1].get_node("Label").text = i[1][0]
			choice_2[1].get_node("OptionButton").selected = i[1][1]
		elif height_dict[int_i][1] == choice_3: # STOP FORGETTING ELSE IFS
			resize(int_i)
			i = i[1]
			choice_3[0].get_node("Label").text = i[0][0]
			choice_3[0].get_node("OptionButton").selected = i[0][1]
			choice_3[1].get_node("Label").text = i[1][0]
			choice_3[1].get_node("OptionButton").selected = i[1][1]
			choice_3[2].get_node("Label").text = i[2][0]
			choice_3[2].get_node("OptionButton").selected = i[2][1]
		elif height_dict[int_i][1] == choice_4:
			resize(int_i)
			i = i[1]
			choice_4[0].get_node("Label").text = i[0][0]
			choice_4[0].get_node("OptionButton").selected = i[0][1]
			choice_4[1].get_node("Label").text = i[1][0]
			choice_4[1].get_node("OptionButton").selected = i[1][1]
			choice_4[2].get_node("Label").text = i[2][0]
			choice_4[2].get_node("OptionButton").selected = i[2][1]
			choice_4[3].get_node("Label").text = i[3][0]
			choice_4[3].get_node("OptionButton").selected = i[3][1]
		elif height_dict[int_i][1] == choice_5:
			resize(int_i)
			i = i[1]
			choice_5[0].get_node("Label").text = i[0][0]
			choice_5[0].get_node("OptionButton").selected = i[0][1]
			choice_5[1].get_node("Label").text = i[1][0]
			choice_5[1].get_node("OptionButton").selected = i[1][1]
			choice_5[2].get_node("Label").text = i[2][0]
			choice_5[2].get_node("OptionButton").selected = i[2][1]
			choice_5[3].get_node("Label").text = i[3][0]
			choice_5[3].get_node("OptionButton").selected = i[3][1]
			choice_5[4].get_node("Label").text = i[4][0]
			choice_5[4].get_node("OptionButton").selected = i[4][1]
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
