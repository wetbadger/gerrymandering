extends HBoxContainer

onready var line_edit = get_node("LineEdit")
var name_gen = load("res://NameGen/NameGen.tscn")
var ng = name_gen.instance()

export var text = "Player 1"

func _ready():
	get_node("Label").text = text
	get_node("LineEdit").text = text

func _on_Random_button_up():
	line_edit.text = ng.new_name().capitalize()
