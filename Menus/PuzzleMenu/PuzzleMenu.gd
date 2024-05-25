extends Node2D

var puzzle_button = load("res://Menus/PuzzleMenu/PuzzleButton.tscn")
onready var grid = get_node("VScrollBar/GridContainer")

func compare_difficulty(a, b):
	if a.difficulty < b.difficulty:
		return -1
	elif b.difficulty < a.difficulty:
		return 1
	else:
		return 0

func _ready():
	#set the map to Puzzles
	#the map is really a menu this time
	Globals.current_map["name"] = "Puzzles"
	
	var buttons = []
	var dir = Directory.new()
	dir.open("res://Puzzles")
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not "." in file:
			
			var pb = puzzle_button.instance()
			buttons.append(pb)
			pb.set_name(file)
			
			var script = load("res://Puzzles/"+file+"/map.tres")
			var data = script.settings
			if data.has("difficulty"):
				pb.set_difficulty(data["difficulty"])
			else:
				pb.difficulty = 0
				print("Error: " + file + " has no setting for diffuclty")
				
			if file in Globals.puzzles_won:
				pb.show_won()
				
	var sorted_buttons = merge_sort(buttons)
	for b in sorted_buttons:
		grid.add_child(b)
		#load thumbnail
		var image = load("res://"+b.path+"/thumbnail.png")
		var c = image.get_class()
		if c != "Image":
			print("Failed to load image res://"+b.path+"/thumbnail.png")
		else:
			var texture = ImageTexture.new()
			texture.create_from_image(image)
			b.set_icon(texture)

	dir.list_dir_end()

func merge_sort(array):
	if array.size() <= 1:
		return array

	var mid = array.size() / 2
	var left = array.slice(0, mid-1)
	var right = array.slice(mid, array.size())

	left = merge_sort(left)
	right = merge_sort(right)

	return merge(left, right)

func merge(left, right):
	var result = []
	var i = 0
	var j = 0

	while i < left.size() && j < right.size():
		if compare_difficulty(left[i], right[j]) <= 0:
			result.append(left[i])
			i += 1
		else:
			result.append(right[j])
			j += 1

	while i < left.size():
		result.append(left[i])
		i += 1

	while j < right.size():
		result.append(right[j])
		j += 1

	return result

func _on_Close_button_up():
	Input.set_custom_mouse_cursor(Globals.pointer)
	queue_free()


func _on_Close_mouse_entered():
	Input.set_custom_mouse_cursor(Globals.hand)


func _on_Close_mouse_exited():
	Input.set_custom_mouse_cursor(Globals.pointer)
