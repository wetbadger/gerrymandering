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

func show_won():
	get_node("Won").visible = true

func _on_Button_button_up():
	var map = load("res://"+path+"/map.tres")
	Globals.current_settings = map.settings
	Globals.current_vertices = map.matrix
	Globals.current_terrain = map.terrain
	Globals.current_map["name"] = map.settings["name"]
	set_process(true)

func _on_Button_mouse_entered():
	Input.set_custom_mouse_cursor(Globals.hand)


func _on_Button_mouse_exited():
	Input.set_custom_mouse_cursor(Globals.pointer)
