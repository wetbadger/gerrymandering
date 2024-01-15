extends Control

signal orientation_changed(portrait)
var last_size
var started_in_portrait = false
var checked_portrait = false
var settings 
onready var music = get_node("MainTheme")
var default_settings = {
	"Audio": 
		{
			"Music": 0.7,
			"Sound": 0.7,
		},
	"Video" : {
			"Orientation": ["sensor","landscape","portrait"],
			"Resolution": ["1920x1080"]
		}
}
#the orientations settings should only show up on mobile devices

onready var main_theme = get_node("MainTheme")
var story = load("res://Story/Story.tscn")
var tutorial = load("res://Story/Tutorial.tscn")
var puzzle_menu = load("res://Menus/PuzzleMenu/PuzzleMenu.tscn")
var about_page = load("res://About/About.tscn")
onready var scene = get_tree().get_current_scene()

func _ready():
	if not OS.request_permissions():
		#assume mobile?
		print ("An unexpected error occured when trying to get OS permissions.")
	set_process(true)
	last_size = get_viewport().size
	if not started_in_portrait and last_size.x < last_size.y:
		started_in_portrait = true
		
	#Write settings file if none exists
	var file = File.new()
	file.open("user://settings.json", File.READ)
	var _settings = parse_json(file.get_as_text())
	if not _settings:
		file.close()
		file.open("user://settings.json", File.WRITE)
		file.store_string(JSON.print(default_settings))
		settings = default_settings
	else:
		settings = _settings
		
	if main_theme:
		main_theme.set_volume(settings["Audio"]["Music"])
		Globals.user_experience_settings["Audio"]["Music"] = settings["Audio"]["Music"]
		
	#reset global variables
	Globals.current_vertices = {}
	Globals.current_settings = {}
	
	Input.set_custom_mouse_cursor(Globals.beam, Input.CURSOR_IBEAM)
		
	
		
func change_value(widget):
	if widget.label == "Music":
		main_theme.set_volume(widget.get_value())
		
	

func _process(_delta):
	if started_in_portrait and not checked_portrait:
		#mobile be weird yo
		var menuitems = get_node("MenuItems")
		if menuitems:
			for btn in menuitems.get_children():
				btn.add_font_override("font", load("res://font/sans_big.tres"))
		checked_portrait = true
	var size = get_viewport().size
	if size.x != last_size.x and size.y != last_size.y:

		emit_signal("orientation_changed", size.x < size.y)

		
	last_size = size
	
	#This code could fade the music with a scene change
#	if start_story:
#		music.volume_db -= 1
#		if music.volume_db <= -50:
#			var error = get_tree().change_scene("res://Story/Story.tscn")
#			if error:
#				print("Could not load story scene")

func start_story():
	var ss = story.instance()
	scene.add_child(ss)
	
func start_tutorial():
	var st = tutorial.instance()
	scene.add_child(st)
	
func open_puzzle_menu():
	var pm = puzzle_menu.instance()
	scene.add_child(pm)
	
func open_about_page():
	var ap = about_page.instance()
	scene.add_child(ap)
