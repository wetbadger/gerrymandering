extends Control

var sprites = []
onready var grid = get_node("ColorRect/GridContainer")
var sprite_selecter_button = load("res://UI/SpriteSelectorButton.tscn")

func _ready():
	var path = "res://pics/sprites/"
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			#break the while loop when get_next() returns ""
			break
		elif !file_name.begins_with(".") and !file_name.ends_with("import"):
			#get_next() returns a string so this can be used to load the images into an array.
			sprites.append(load(path + file_name))
	dir.list_dir_end()
	
	for sprite in sprites:
		if sprite:
			var sb = sprite_selecter_button.instance()
			sb.texture_normal = sprite
			sb.set_scale(Vector2(10,10))
			grid.add_child(sb)
