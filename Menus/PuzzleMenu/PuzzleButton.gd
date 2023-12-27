extends VBoxContainer

export var path :String = ""
var difficulty = 0

var music
onready var scene = get_tree().get_current_scene()
onready var button = get_node("Button")
onready var label = get_node("Panel/Name")
onready var panel = get_node("Panel")

func _ready():
	set_process(false)
	music = scene.get_node("MainTheme")
	scene = scene.get_children()[-1]

func _process(_delta):
	music.volume_db -= 1
	if music.volume_db <= -50:
		var error = get_tree().change_scene("res://Game/main.tscn")
		if error:
			print("Could not load main scene")

func set_name(name):
	get_node("Panel/Name").text = name
	path = "Puzzles/" + name
	
func set_icon(texture):
	button.icon = texture
	
func set_difficulty(d):
	var i = 0
	for star in get_node("Difficulty").get_children():
		if i == d:
			break
		star.visible = true
		i+=1
	difficulty = d

func _on_Button_button_up():
	var file = File.new()
	if not file.file_exists("res://"+path+"/settings.json"):
		print("res://"+path+" does not exist.")
		return
	file.open("res://"+path+"/settings.json", File.READ)
	var settings = parse_json(file.get_as_text())
	Globals.current_settings = settings
	file.close()
	
	file = File.new()
	if not file.file_exists("res://"+path+"/matrix.json"):
		print("res://"+path+" does not exist.")
		return
	file.open("res://"+path+"/matrix.json", File.READ)
	var matrix = parse_json(file.get_as_text())
	Globals.current_vertices = matrix
	file.close()
	
	file = File.new()
	if file.file_exists("res://"+path+"/terrain.json"):
		file.open("res://"+path+"/terrain.json", File.READ)
		Globals.current_terrain = parse_json(file.get_as_text())
		file.close()
	set_process(true)
