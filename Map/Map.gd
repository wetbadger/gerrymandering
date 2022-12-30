extends Node2D

signal orientation_changed(portrait)

var current_selection
var last_size

var orientation = "landscape"

onready var container = get_node("Container")
onready var btn_container = get_node("ButtonContainer")

func _ready():
	
	last_size = get_viewport().size
	connect("orientation_changed", self, "_on_orientation_changed")

	if last_size.x < last_size.y:
		container.rotate(deg2rad(90))
		flip_portrait()
	else:
		flip_landscape()

func _process(_delta):
	var size = get_viewport().size
	if size.x != last_size.x and size.y != last_size.y:
		emit_signal("orientation_changed", size.x < size.y)
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
