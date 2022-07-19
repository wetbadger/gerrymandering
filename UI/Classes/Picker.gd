extends Control

class_name Picker

#
#	A pane which gives an assortment of options
#

func populate(dict):
	for key in dict:
		print(key + str(dict[key]))
		
func insert(elem):
	get_node("GridContainer").add_child(elem)
		
func set_width(n):
	get_node("GridContainer").set_columns(n)
