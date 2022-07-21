extends Control

class_name Pane
onready var BLabel = load("res://UI/Widgets/BLabel.tscn")
onready var BLineEdit = load("res://UI/Widgets/BLineEdit.tscn")
onready var BSpinBox = load("res://UI/Widgets/BSpinBox.tscn")
onready var BSpritePicker = load("res://UI/Widgets/BSpritePickerButton.tscn")
onready var BColorPicker = load("res://UI/Widgets/BColorPickerButton.tscn")
onready var BIconGrid = load("res://UI/Widgets/BIconGrid.tscn")
onready var tilemap = load("res://Objects/Tiles/SpriteTiles.tscn").instance()
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

func display_groups(content, icon_grid_size=2):
	#add children to hboxes and vboxes
	var vbox = VBoxContainer.new()
	add_child(vbox)
	var icon_grid
	var icon_count = 0
	for g in groups:
		
		match g[0]:
			"line":
				var line = BLineEdit.instance()
				line.set_text(g[1])
				#print(g[1])
				g[2] = line #store the label node itself
				vbox.add_child(line)
			"number":
				var spinbox = BSpinBox.instance()
				spinbox.set_text(g[1])
				spinbox.set_value(g[2])
				g[3] = spinbox
				vbox.add_child(spinbox)
			"asset":
				var spritepicker = BSpritePicker.instance()
				#spritepicker.rect_min_size.y = 50 #could adjust for sprite size
				spritepicker.set_sprite(g[1])
				g[2] = spritepicker
				#vbox.add_child(spritepicker)
				if not icon_grid:
					icon_grid = BIconGrid.instance()
					icon_grid.rect_min_size.y = 40
					vbox.add_child(icon_grid)
					#icon_grid.hseparation = 40
				var box = icon_grid.get_node("GridContainer/Box1")
				box.add_child(spritepicker)
				spritepicker.set_sprite_index(tilemap)
				icon_count+=1
				
			"color":
				var colorpicker = BColorPicker.instance()
				colorpicker.rect_min_size.y = 50 #could adjust for sprite size
				var col_arr = get_node("/root/Globals").default_settings["colors"][g[1]]
				var color = Color(col_arr[0], col_arr[1], col_arr[2])
				colorpicker.set_color(color, g[1])
				g[2] = colorpicker
				#vbox.add_child(colorpicker)
				if not icon_grid:
					icon_grid = BIconGrid.instance()
					icon_grid.rect_min_size.y = 40
					vbox.add_child(icon_grid)
					#icon_grid.hseparation = 40
				var box = icon_grid.get_node("GridContainer/Box2")
				box.add_child(colorpicker)
				icon_count+=1

			_:
				print("Widget type not specified")
		
		if icon_grid:
			if icon_count >= icon_grid_size:
				icon_count = 0
				icon_grid = null
