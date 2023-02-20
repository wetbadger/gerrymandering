extends Node2D

onready var textbox = $RichTextLabel/BLabel
var text_complete = true
var speed = 0.0

func set_text(text):
	textbox.text = ""
	text_complete = false
	for c in text:
		textbox.text += c
		yield(get_tree().create_timer(speed), "timeout")
	text_complete = true
