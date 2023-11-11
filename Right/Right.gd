extends Control

@onready var mount = $ScrollContainer/MarginContainer/HBoxContainer
@onready var RB = preload("res://Right/Branch.tscn")

var alphabet = ['A','B','C','D','E','F','G','H','I','J']

func _ready():
	for i in range(10):
		var b = RB.instantiate()
		b.set_title(alphabet[i])
		mount.add_child(b)
