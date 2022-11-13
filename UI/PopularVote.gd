extends Control

onready var grid = get_node("VBoxContainer/CenterContainer/Scroll/CenterContainer/GridContainer")
onready var scroll = get_node("VBoxContainer/CenterContainer/Scroll")
var percent_scn = load("res://UI/Percent.tscn")
onready var settings = get_tree().get_current_scene().settings

func _ready():
	pass
	
func add_party(party, votes, percent=0):
	if not settings:
		settings = get_tree().get_current_scene().settings
	
	var percent_label = percent_scn.instance()
	percent_label.set_text(str(percent))
	var percent_symbol = percent_scn.instance()
	percent_symbol.set_text('%')
	var rect = ColorRect.new()
	var color = Globals.word2color(settings["parties"][party]["color"])
	color.a = 0.8
	rect.color = color
	rect.rect_min_size = Vector2(33,33)
	rect.anchor_bottom = 0.75
	rect.anchor_top = 0.75
	
	percent_label.add_child(rect)
	
	grid.add_child(percent_label)
	grid.add_child(percent_symbol)
	
	var party_label = Label.new()
	party_label.set_text(party+": ")
	var votes_label = Label.new()
	votes_label.set_text(str(votes))
	grid.add_child(party_label)
	grid.add_child(votes_label)

