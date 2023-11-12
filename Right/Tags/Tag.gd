extends HBoxContainer

@export var Text: String

func _ready():
	$Label.text = Text

func is_checked():
	var a = $CheckBox.button_pressed
	if a == true:
		return Text

func set_checked(f):
	if f.has(Text):
		$CheckBox.button_pressed = true
	else:
		$CheckBox.button_pressed = false
