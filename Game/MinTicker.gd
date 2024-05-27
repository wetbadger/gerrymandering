extends Control

onready var label = get_node("MinTickerLabel")
onready var icon = get_node("MinSymbol")

func set_color(n):
	if n == 0:
		label.add_color_override("font_color", Color("00ff00"))
		icon.modulate = Color("00ff00")
	elif n < 0:
		label.add_color_override("font_color", Color("ff0000"))
		icon.modulate = Color("ff0000")
	else:
		label.add_color_override("font_color", Color("ffffff"))
		icon.modulate = Color("ffffff")

func minimum():
	var n = int(label.text) - 1
	label.text = str(n)
	set_color(n)
		
func not_minimum():
	var n = int(label.text) + 1
	label.text = str(n)
	set_color(n)
