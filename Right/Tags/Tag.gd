extends HBoxContainer

@export var Text: String

func _ready():
	$Label.text = Text

func is_checked():
	var a = $CheckBox.button_pressed
	if a == true:
		return Text

func disable_checks():
	$CheckBox.button_pressed = false

func set_checked(f):
	$CheckBox.button_pressed = f.has(Text)
