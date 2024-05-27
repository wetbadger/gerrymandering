extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect_cursor_signals()
		
func connect_cursor_signals():
	for btn in get_children():
		#connect mouseover signals
		if btn.connect('mouse_entered', self, '_on_mouse_entered') != OK:
			print("Error: mouse enter signal not connected")
		if btn.connect('mouse_exited', self, '_on_mouse_exited') != OK:
			print("Error: mouse exit signal not connected")
			
func _on_mouse_entered():
	Input.set_custom_mouse_cursor(Globals.hand)
	
func _on_mouse_exited():
	Input.set_custom_mouse_cursor(Globals.pointer)
