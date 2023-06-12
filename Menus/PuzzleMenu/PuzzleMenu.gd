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
		elif not file.begins_with("."):

			var pb = puzzle_button.instance()
			buttons.append(pb)
			pb.set_name(file)
			
			#load difficulty from json
			var settings = File.new()
			if not settings.file_exists("res://Puzzles/"+file+"/settings.json"):
				return
			settings.open("res://Puzzles/"+file+"/settings.json", File.READ)
			var data = parse_json(settings.get_as_text())
			if data.has("difficulty"):
				pb.set_difficulty(data["difficulty"])
			else:
				pb.difficulty = 0
				print("Error: " + file + " has no setting for diffuclty")
				
			
				
	var sorted_buttons = merge_sort(buttons)
	for b in sorted_buttons:
		grid.add_child(b)
		#load thumbnail
		var image = Image.new()
		var error = image.load("res://"+b.path+"/thumbnail.png")
		if error != OK:
			print("Failed to load image:", error)
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
	queue_free()
