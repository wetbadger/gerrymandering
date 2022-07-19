extends Control

class_name Pane
onready var BLabel = load("res://UI/Widgets/BLabel.tscn")
onready var BLineEdit = load("res://UI/Widgets/BLineEdit.tscn")
onready var BSpinBox = load("res://UI/Widgets/BSpinBox.tscn")
onready var BSpritePicker = load("res://UI/Widgets/BSpritePickerButton.tscn")
onready var BColorPicker = load("res://UI/Widgets/BColorPickerButton.tscn")

var groups = [] # array of [type, contents, node_instance]

func _ready():
	pass

func add_line(text):
	groups.append(["line", text, null])
	
func add_spinbox(text, value):
	groups.append(["number", text, value, null])
	
func add_sprite_picker(path):
	groups.append(["asset", path, null])
	
func add_color_picker(color):
	groups.append(["color", color, null])

func display_groups():
	#add children to hboxes and vboxes
	var vbox = VBoxContainer.new()
	add_child(vbox)
	for g in groups:
		match g[0]:
			"line":
				var line = BLineEdit.instance()
				line.set_text(g[1])
				print(g[1])
				g[2] = line #store the label node itself
				vbox.add_child(line)
			"number":
				var spinbox = BSpinBox.instance()
				spinbox.set_text(g[1])
				spinbox.set_value(g[2])
				g[3] = spinbox
				vbox.add_child(spinbox)
			"_asset":
				var spritepicker = BSpritePicker.instance()
				#spritepicker.rect_min_size.y = 50 #could adjust for sprite size
				spritepicker.set_sprite(g[1])
				g[2] = spritepicker
				vbox.add_child(spritepicker)
			"color":
				var colorpicker = BColorPicker.instance()
				colorpicker.rect_min_size.y = 50 #could adjust for sprite size
				colorpicker.set_color(g[1])
				g[2] = colorpicker
				vbox.add_child(colorpicker)
			_:
				print("Widget type not specified")
	pass
