extends Node2D

onready var textbox = $RichTextLabel/BLabel
var text_complete = true
var speed = 0.0

var stop = false

func set_text(text):
	textbox.set_text("")
	text_complete = false
	for c in text:
		if stop:
			stop = false
			break
		textbox.text += c
		yield(get_tree().create_timer(speed), "timeout")
	text_complete = true
	
func set_text_now(text):
	stop = true
	textbox.set_text(text)
	text_complete = true
