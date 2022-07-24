extends Node2D

var parties_pane = load("res://UI/Panes/PartiesPane.tscn")
var districts_pane = load("res://UI/Panes/DistrictsPane.tscn")
var advanced_pane = load("res://UI/Panes/AdvancedPane.tscn")

var BLabel = load("res://UI/Widgets/BLabel.tscn")
onready var game_name = get_node("TabContainer/Basic/HBoxContainer/Grid/NameText")
onready var default_state = load("res://Objects/States/Rectagonia.tscn").instance()
var windows_open = []
var max_windows_open = 1

var settings
var panes = []

var state_shape
var state_name

func _ready():
	
	state_shape = default_state
	
	set_state_shape(state_shape)
	
	var pp = parties_pane.instance()
	add_pane("Basic", "Parties", pp)
	var dp = districts_pane.instance()
	add_pane("Basic", "Districts", dp, "Grid2", Vector2(450,550))
	
	#connect number of houses with district size
	for elem in dp.groups:
		if elem[0] == "number":
			if elem[1] == "max_size":
				pp.add_district_max_box(elem[-1])
			elif elem[1] == "min_size":
				pp.add_district_min_box(elem[-1])
				
	#connect number of voters with max_sizes
	for elem in pp.groups:
		if elem[0] == "number":
			if elem[1] == "voters":
				dp.add_voter_spinbox(elem[-1])
		
	
	var adv = advanced_pane.instance()
	add_pane("Advanced", "", adv)
	
	settings = load_settings()
	game_name.set_text(settings["name"])

func add_pane(tab_name, lbl_name, pane, container_name="Grid", size=Vector2(400,350)):
	var grid = get_node("TabContainer").get_node(tab_name).get_node("HBoxContainer").get_node(container_name)
	var label = BLabel.instance()
	var scrollbox = ScrollContainer.new()
	scrollbox.set_name("Scroll")
	var vbar = scrollbox.get_v_scrollbar()
	vbar.rect_min_size.x = 16
	#print(scrollbox.get_v_scroll())
	scrollbox.rect_min_size = size
	label.set_text(lbl_name)
	label.anchor_top = 1
	grid.add_child(label)
	scrollbox.add_child(pane)
	grid.add_child(scrollbox)
	panes.append(pane)

func set_state_shape(_state_shape):
	state_shape = _state_shape
	get_node("TabContainer/Basic/HBoxContainer/Grid/BStatePickerButton").set_state(_state_shape)
	state_name = _state_shape.name

func load_settings():
	var file = File.new()
	if not file.file_exists("user://settings.json"):
			create_default_settings()
			return get_node("/root/Globals").default_settings
	file.open("user://settings.json", File.READ)
	var data = parse_json(file.get_as_text())
	return data
	
func create_default_settings():
	var file = File.new()
	file.open("user://settings.json", File.WRITE)
	var defaults = get_node("/root/Globals").default_settings
	file.store_line(JSON.print(defaults, "\t"))
	file.close()