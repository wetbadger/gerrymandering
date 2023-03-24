extends Node2D

export var map_name = "Tutoria"

signal orientation_changed(portrait)

var current_selection
var last_size

var orientation = "landscape"

onready var container = get_node("Container")
onready var btn_container = get_node("ButtonContainer")
onready var dialog = get_node("Dialog")

var node_at = -1

func _ready():
	Globals.current_map["name"] = map_name
	Globals.current_map["scene"] = get_tree().current_scene.filename
	
	last_size = get_viewport().size

	connect("orientation_changed", self, "_on_orientation_changed")

	if last_size.x < last_size.y:
		container.rotate(deg2rad(-90))
		var y_value = container.get_global_position().y
		
		flip_portrait()
	else:
		flip_landscape()
		
	get_node("MapTheme").set_volume(Globals.user_experience_settings["Audio"]["Music"])

	for node in Globals.map_progress[map_name].keys():
		
		if node == "completed":
			continue
		var node_state = Globals.map_progress[map_name][node]
		if node_state == true:
			dialog.get_children()[0].add_node(get_node("Container/"+node))
			
	if Globals.map_progress[map_name]["completed"]:
		for node in container.get_children():
			if node.name != "Sprite" and node.name != "FlashingArrow":
				node.enable()
				node.visible = true

func _process(_delta):
	var size = get_viewport().size
	if size.x != last_size.x and size.y != last_size.y:
		emit_signal("orientation_changed", size.x < size.y)
		#dialog.set_global_position(Vector2(300, last_size.y - 330))
	last_size = size
	
func flip_portrait():
	
	var current_size = get_viewport_rect().size
	container.position.x = current_size.x / 2
	container.position.y = current_size.y - current_size.y * 0.3
	orientation = "portrait"
	btn_container._ready()
	
func flip_landscape():
	var current_size = get_viewport_rect().size
	container.position.y = current_size.y / 2
	container.position.x = current_size.x - current_size.x * 0.75
	orientation = "landscape"
	btn_container._ready()

func _on_orientation_changed(portrait):
		if portrait:
			if orientation != "portrait":
				container.rotate(deg2rad(-90))
				flip_portrait()
		else:
			if orientation != "landscape":
				container.rotate(deg2rad(90))
				flip_landscape()
