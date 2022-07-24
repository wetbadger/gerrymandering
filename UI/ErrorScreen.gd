extends Node2D


func set_error_name(text):
	get_node("VBoxContainer/ErrorName").text = text
	
func set_error_message(text):
	get_node("VBoxContainer/ErrorMessage").text = text
