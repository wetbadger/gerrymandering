extends Node2D

var usrexp_settings_pane = load("res://UI/Panes/UsrexpSettingsPane.tscn")
var uxsp

var BLabel = load("res://UI/Widgets/BLabel.tscn")
var BScrollContainer = load("res://UI/Widgets/BScroll.tscn")

onready var scene = get_tree().get_current_scene()

var panes = []
var windows_open = []
var settings

func _ready():
	var error = get_node("/root/MainMenu").connect("orientation_changed", self, "_on_orientation_changed")
	if error:
		print("There was an error in StartStory.gd")
	
	uxsp = usrexp_settings_pane.instance()
	add_pane("General", null, uxsp, "VBoxContainer/Grid")
	
	settings = scene.settings

func add_pane(tab_name, _lbl_name, pane, container_name="Grid", size=Vector2(700,450)):
	var grid = get_node("TabContainer").get_node(tab_name).get_node("HBoxContainer").get_node(container_name)

	var scrollbox = BScrollContainer.instance()
	scrollbox.set_name("Scroll")
	var vbar = scrollbox.get_v_scrollbar()
	vbar.rect_min_size.x = 16
	#print(scrollbox.get_v_scroll())
	scrollbox.rect_min_size = size

	scrollbox.add_child(pane)
	grid.add_child(scrollbox)

	panes.append(pane)
	
func reposition():
	var rect = get_viewport_rect().size
	set_position(Vector2(rect.x/2-get_node("TabContainer").get_size().x/2, rect.y/2-get_node("TabContainer").get_size().y/1.5))

func _on_orientation_changed(portrait):
	reposition()
	print(str(portrait))

func _on_Close_button_up():
	for w in windows_open:
		w.close_window()
	#scene.main_theme.set_volume(scene.settings["Audio"]["Music"])
	queue_free()
