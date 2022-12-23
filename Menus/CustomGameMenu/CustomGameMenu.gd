extends Node2D

#Load settings from a JSON

#Read from a file that contains the last saved game names
#games.json
#[
#    "My State",
#    "My State 2"
#]
#Load the settings from the top name.
#Upon clicking save, the settings from that game will be loaded, and the game name will be moved to the top.

var parties_pane = load("res://UI/Panes/PartiesPane.tscn")
var districts_pane = load("res://UI/Panes/DistrictsPane.tscn")
var advanced_pane = load("res://UI/Panes/AdvancedPane.tscn")

var BLabel = load("res://UI/Widgets/BLabel.tscn")
var BScrollContainer = load("res://UI/Widgets/BScroll.tscn")
onready var game_name = get_node("TabContainer/Basic/HBoxContainer/VBoxContainer/HBoxContainer/NameText")
onready var default_state = load("res://Objects/States/Rectagonia.tscn").instance()
var windows_open = []
var max_windows_open = 1

var settings
var panes = []
var scrollboxes_and_labels = []

var state_shape
var state_name
var pp
var dp
var adv


#
# Idea for potential "flex stacking" in portait mode
#
onready var current_container = get_node("TabContainer")
onready var other_container = get_node("TabContainer2")

func _ready():
	
	get_node("/root/MainMenu").connect("orientation_changed", self, "_on_orientation_changed")

	state_shape = default_state
	settings = load_settings()
	if not settings:
		settings = Globals.default_settings
	state_shape = load("res://Objects/States/"+settings["shape"]+".tscn").instance()
	set_state_shape(state_shape)
	
	pp = parties_pane.instance()
	add_pane("Basic", "Parties", pp, "VBoxContainer/Grid")
	dp = districts_pane.instance()
	add_pane("Basic", "Districts", dp, "Grid2", Vector2(450,550))
	
	#connect number of houses with district size
	for elem in dp.groups:
		if elem[0] == "number":
			if elem[1] == "max":
				pp.add_district_max_box(elem[-1])
			elif elem[1] == "min":
				pp.add_district_min_box(elem[-1])
				
	#connect number of voters with max_sizes
	for elem in pp.groups:
		if elem[0] == "number":
			if elem[1] == "voters":
				dp.add_voter_spinbox(elem[-1])
		
	
	adv = advanced_pane.instance()
	add_pane("Advanced", "Advanced Options", adv)
	
	if settings.has("name"):
		game_name.set_text(settings["name"])
	else:
		game_name = "My State"

func add_pane(tab_name, lbl_name, pane, container_name="Grid", size=Vector2(400,350)):
	var grid = get_node("TabContainer").get_node(tab_name).get_node("HBoxContainer").get_node(container_name)
	var label = BLabel.instance()
	var scrollbox = BScrollContainer.instance()
	scrollbox.set_name("Scroll")
	var vbar = scrollbox.get_v_scrollbar()
	vbar.rect_min_size.x = 16
	#print(scrollbox.get_v_scroll())
	scrollbox.rect_min_size = size
	label.set_text(lbl_name)
	label.anchor_top = 1
	grid.add_child(label)
	scrollbox.add_child(pane)
	scrollboxes_and_labels.append(scrollbox)
	scrollboxes_and_labels.append(label)
	grid.add_child(scrollbox)
	panes.append(pane)

func set_state_shape(_state_shape):
	state_shape = _state_shape
	current_container.get_node("Basic/HBoxContainer/VBoxContainer/Grid/BStatePickerButton").set_state(_state_shape)
	state_name = _state_shape.name

func load_settings():
	var file = File.new()

	file.open("user://games.json", File.READ)
	var games = parse_json(file.get_as_text())
	var gameName
	if not games:
		file.close()
		file.open("user://games.json", File.WRITE)
		file.store_string('["My State"]')
		gameName = "My State"
		var dir = Directory.new()
		dir.open("user://")
		var err = dir.make_dir(gameName)
		if err:
			print("Could not make directory")
			#if err == 32:
			#	prompt_user_to_overwrite()
		file.close()
		file.open("user://"+gameName+"/settings.json", File.WRITE)
		file.store_string(JSON.print(Globals.default_settings, "\t"))
		file.close()
		
	else:
		gameName = games[0]
	file.close()
	file.open("user://"+gameName+"/settings.json", File.READ)
	var data = parse_json(file.get_as_text())
	file.close()
	#return Globals.default_settings.duplicate(true)
	return data
	
func create_default_settings():
	var file = File.new()
	file.open("user://"+game_name+"settings.json", File.WRITE)
	var defaults = Globals.default_settings.duplicate(true)
	file.store_line(JSON.print(defaults, "\t"))
	file.close()
	
func _unhandled_input(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE:
		for w in windows_open:
			w.close_window()
		queue_free()
		
func reload():
	for p in scrollboxes_and_labels:
		p.queue_free()
	scrollboxes_and_labels = []
	panes = []
	_ready()
	pp.set_name("parties")
	dp.set_name("districts")
	pp.deferred_ready()
	
func reposition():
	var rect = get_viewport_rect().size
	set_position(Vector2(rect.x/2-get_node("TabContainer").get_size().x/2, rect.y/2-get_node("TabContainer").get_size().y/1.5))
	
func _on_orientation_changed(portrait):
	reposition()
	pass
#	if portrait:
#		get_node("TabContainer").set_size(Vector2(793, 1457))
#		current_container.rect_size = (Vector2(92, 631))
#
#	else:
#		get_node("TabContainer").set_size(Vector2(457, 793))
#		current_container.rect_size = (Vector2(631, 92))
		


func _on_Close_button_up():
	for w in windows_open:
		w.close_window()
	queue_free()
