extends Control

class_name Pane

onready var scene = get_tree().get_current_scene()
onready var BLabel = load("res://UI/Widgets/BLabel.tscn")
onready var BLineEdit = load("res://UI/Widgets/BLineEdit.tscn")
onready var BSpinBox = load("res://UI/Widgets/BSpinBox.tscn")
onready var BSpritePicker = load("res://UI/Widgets/BSpritePickerButton.tscn")
onready var BColorPicker = load("res://UI/Widgets/BColorPickerButton.tscn")
onready var BIconGrid = load("res://UI/Widgets/BIconGrid.tscn")
onready var BCheckBox = load("res://UI/Widgets/BCheckBox.tscn")
onready var BOptionMenu = load("res://UI/Widgets/BOptionMenu.tscn")

onready var BAddAndSubtractButtons = load("res://UI/Widgets/BAddAndSubtractButtons.tscn")

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
	
func add_checkbox(text, value):
	groups.append(["bool", text, value, null])
	
func add_optmenu(text, options):
	groups.append(["list", text, options, null])
	
func add_plus_or_minus(text, pane): #on which pane is the add button adding elements?
	groups.append(["add", text, pane, null])

func display_groups(content, icon_grid_size=2):
	#add children to hboxes and vboxes
	var vbox
	if has_node("VBox"):
		get_node("VBox").queue_free()
	vbox = VBoxContainer.new()
	vbox.set_name("VBox")
	add_child(vbox)
	var icon_grid
	var icon_count = 0
	var line
	for g in groups:
		match g[0]:
			"line":
				line = BLineEdit.instance()
				line.set_text(g[1])
				#print(g[1])
				g[2] = line #store the label node itself
				vbox.add_child(line)
				g[-1] = line
			"number":
				var spinbox = BSpinBox.instance()
				spinbox.set_text(g[1])
				spinbox.set_value(g[2])
				g[3] = spinbox
				spinbox.set_label_name(line.text)
				vbox.add_child(spinbox)
				g[-1] = spinbox
			"bool":
				var checkbox = BCheckBox.instance()
				checkbox.text = g[1]
				checkbox.pressed = g[2]
				g[3] = checkbox
				vbox.add_child(checkbox)
				g[-1] = checkbox
			"list":
				var optmenu = BOptionMenu.instance()
				optmenu.text = g[1]
				for each in g[2]:
					optmenu.add_item(each)
				g[3] = optmenu
				vbox.add_child(optmenu)
				g[-1] = optmenu
			#
			#		Icons
			#
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
				g[-1] = spritepicker
			
			"color":
				var colorpicker = BColorPicker.instance()
				colorpicker.rect_min_size.y = 50 #could adjust for sprite size
				var col_arr = Globals.default_settings["colors"][g[1]]
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
				g[-1] = colorpicker
			"add":
				var plus_min = BAddAndSubtractButtons.instance()
				plus_min.rect_scale = Vector2(0.1,0.1)
				vbox.add_child(plus_min)
				g[-1] = plus_min
				plus_min.set_name(g[1])
				plus_min.set_add(g[2])
			_:
				print("Widget type not specified")
		
		if icon_grid:
			if icon_count >= icon_grid_size:
				icon_count = 0
				icon_grid = null
