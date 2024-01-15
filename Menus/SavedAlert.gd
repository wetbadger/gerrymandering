extends Control

onready var label = $Panel/VBoxContainer/BLabel

func set_text(text):
	label.text = text

func _on_Button_button_up():
	queue_free()
