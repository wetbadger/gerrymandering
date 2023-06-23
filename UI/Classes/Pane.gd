extends Control

class_name Pane

onready var scene = get_tree().get_current_scene().get_children()[-1]
onready var BLabel = load("res://UI/Widgets/BLabel.tscn")
onready var BLineEdit = load("res://UI/Widgets/BLineEdit.tscn")
onready var BSpinBox = load("res://UI/Widgets/BSpinBox.tscn")
onready var BSpritePicker = load("res://UI/Widgets/BSpritePickerButton.tscn")
onready var BColorPicker = load("res://UI/Widgets/BColorPickerButton.tscn")
onready var BIconGrid = load("res://UI/Widgets/BIconGrid.tscn")
onready var BCheckBox = load("res://UI/Widgets/BCheckBox.tscn")
onready var BOptionMenu = load("res://UI/Widgets/BOptionMenu.tscn")
onready var BSlider = load("res://UI/Widgets/BSlider.tscn")

onready var BAddAndSubtractButtons = load("res://UI/Widgets/BAddAndSubtractButtons.tscn")

onready var tilemap = load("res://Objects/Tiles/SpriteTiles3.tscn").instance()
var groups = [] # array of [type, contents, node_instance]
var is_read_only = false
var isAddable = true
var BOX

func _ready():
	pass

func add_line(text):
	groups.append(["line", text, null])
	
func add_label(text):
	groups.append(["label", text, null])
	
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
	
func add_slider(text, value):
	groups.append(["slider", text, value, null])

func set_elements(box, icon_grid_size=2):
	#build the pane from elements in a dictionary
	var vbox
	if has_node("VBox"):
		#get_node("VBox").queue_free()
		vbox = get_node("VBox")
	else:
		vbox = VBoxContainer.new()
		vbox.set_name("VBox")
		add_child(vbox)
		
	var icon_grid
	var icon_count = 0
	var line
	
	var boxes = box.groups

	for g in boxes:
		var a = 40
		if not g[-1]:
			rect_min_size.y += 65
			match g[0]:
				"line":
					if box.is_read_only:
						line = BLabel.instance()
					else:
						line = BLineEdit.instance()
					line.set_text(g[1])
					#print(g[1])
					g[2] = line #store the label node itself
					box.get_node("VBox").add_child(line)
					g[-1] = line
					box.rect_min_size.y += line.rect_size.y + a
				"number":
					var spinbox = BSpinBox.instance()
					spinbox.set_text(g[1])
					spinbox.set_value(g[2])
					g[3] = spinbox
					spinbox.set_label_name(line.text)
					box.get_node("VBox").add_child(spinbox)
					g[-1] = spinbox
					box.rect_min_size.y += spinbox.rect_size.y + a
				"bool":
					var checkbox = BCheckBox.instance()
					checkbox.text = g[1]
					checkbox.pressed = g[2]
					g[3] = checkbox
					box.get_node("VBox").add_child(checkbox)
					g[-1] = checkbox
					box.rect_min_size.y += checkbox.rect_size.y + a
				"list":
					var optmenu = BOptionMenu.instance()
					optmenu.text = g[1]
					for each in g[2]:
						if typeof(each) == TYPE_STRING:
							optmenu.add_item(each)
						else:
							print("error: Option Menu item "+str(each)+" not a string")
					g[3] = optmenu
					box.get_node("VBox").add_child(optmenu)
					g[-1] = optmenu
					box.rect_min_size.y += optmenu.rect_size.y + a
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
						box.get_node("VBox").add_child(icon_grid)
						box.rect_min_size.y += icon_grid.rect_size.y + a
						#icon_grid.hseparation = 40
					var grdbox = icon_grid.get_node("GridContainer/Box1")
					grdbox.add_child(spritepicker)
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
						box.get_node("VBox").add_child(icon_grid)
						box.rect_min_size.y += icon_grid.rect_size.y + a
						#icon_grid.hseparation = 40
					var grdbox = icon_grid.get_node("GridContainer/Box2")
					grdbox.add_child(colorpicker)
					icon_count+=1
					g[-1] = colorpicker
				"slider":
					var slider = BSlider.instance()
					slider.set_text(g[1])
					slider.set_value(g[2])
					slider.set_label_name(line.text)
					box.get_node("VBox").add_child(slider)
					g[-1] = slider
					box.rect_min_size.y += slider.rect_size.y + a
					#slider.rext_min_size.y = 50

				_:
					print("Widget type not specified")

		if icon_grid:
			if icon_count >= icon_grid_size:
				icon_count = 0
				icon_grid = null
		
		if not box.get_parent():
			vbox.add_child(box)

func display_groups(content):
	#add children to hboxes and vboxes
	for box in content:
		set_elements(box)
		
	if isAddable:
		#Yes, This produces an error
		#DO NOT delete
		var pm_node = get_node("VBox/BAddAndSubtractButtons")
		var main_vbox = get_node("VBox")
		if pm_node:
			main_vbox.move_child(pm_node, len(main_vbox.get_children()))
		else:
			var plus_min = BAddAndSubtractButtons.instance()
			main_vbox.add_child(plus_min)
			plus_min.set_add(BOX)
		

func set_read_only(boolean):
	#sets line edits to read only
	get_node("VBox/BLineEdit").editable = boolean
