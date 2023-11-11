extends Panel

var current_ID = -1
var current_text = ""

var th = 236 #Text Box Height
@onready var te = $MarginContainer/VBoxContainer/TextEdit
@onready var o = $MarginContainer/VBoxContainer/OptionButton

@onready var height_dict = {
	003: [th, te],
	100: [th, te],
	101: [th, te],
	102: [th, te]
}

func dump_data():
	if current_ID < 1:
		return
	if height_dict[current_ID][1] == te:
		return [current_ID, current_text]

func _on_option_button_item_selected(index):
	index = o.get_selected_id()
	current_ID = index
	
	if index == 0:
		return
	
	if index == 003:
		$MarginContainer/VBoxContainer/TextEdit.placeholder_text = "Enter comment here. This will be completely ignored by the game."
	else:
		$MarginContainer/VBoxContainer/TextEdit.placeholder_text = "Me? Getting married and having a happy life would be OK, I guess..."
	#print(height_dict[index])
	self.custom_minimum_size.y = height_dict[index][0]
	height_dict[index][1].show()
	current_ID = index

func _on_text_edit_focus_entered():
	Global.set_focused(true)

func _on_text_edit_focus_exited():
	Global.set_focused(false)

func _on_text_edit_text_changed():
	current_text = te.text
