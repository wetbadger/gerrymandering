extends HBoxContainer

var parties = {}
var size
onready var colors = Globals.default_settings["colors"]
var settings

func _ready():
	size = rect_size
	var scene = get_tree().get_current_scene()
	var map_name = scene.map_name
	if Globals.save_progress:
		var file = File.new()
		file.open("user://"+map_name+"/settings.json", File.READ)
		settings = parse_json(file.get_as_text())
	else:
		settings = Globals.current_settings
#	add_party("Red Party", "red")
#	add_party("Blue Party", "blue")

func add_party(party, color, n=1):
	parties[party] = {} 
	parties[party]["color"] = color
	parties[party]["voters"] = n
	
	var new_rect = ColorRect.new()
	new_rect.color = Globals.arr2color(colors[color])
	new_rect.rect_min_size.y = size.y
	add_child(new_rect)
	new_rect.name = party
	parties[party]["rect"] = new_rect
	resize()	
	
func resize():
	var sum = 0.0
	for p in parties:
		sum += parties[p]["voters"]
		
	for p in parties:
		var bar_size
		if sum > 0:
			var ratio = parties[p]["voters"] / sum
			bar_size = size.x * ratio
		else:
			bar_size = 0
		resize_bar(parties[p]["rect"], bar_size)
		
	
func resize_bar(rect, amt):
	rect.rect_size = Vector2(amt, size.y)
	rect.rect_min_size.x = amt
	
func set_votes(party, n):
	if not parties.has(party):
		add_party(party, settings["parties"][party]["color"], n)
	parties[party]["voters"] = n
	resize()
	
func reset():
	parties = {}
	for child in get_children():
		child.queue_free()
