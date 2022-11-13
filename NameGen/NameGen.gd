extends Node

var rng = RandomNumberGenerator.new()
var names

func _ready():
	names = load_names()
	rng.randomize()
	
func _init():
	names = load_names()
	rng.randomize()

func new_name():
	var i = rng.randi_range(0, len(names["prefixes"]) - 1)
	var word = names["prefixes"][i]
	rng.randomize()
	i = rng.randi_range(0, len(names["suffixes"]) - 1)
	word += names["suffixes"][i]
	rng.randomize()
	if (rng.randf() > 0.9):
		rng.randomize()
		i = rng.randi_range(0, len(names["affixes"]) - 1)
		word = names["affixes"][i]+word
		
	return word
	
func load_names():
	if Globals.save_progress: #TODO: let user modify names?
		var file = File.new()
		if not file.file_exists("user://names.json"):
				create_name_file()
				return Globals.default_settings.duplicate(true)
		file.open("user://names.json", File.READ)
		var data = parse_json(file.get_as_text())
		return data
	else:
		return Globals.default_names
	
func create_name_file():
	var file = File.new()
	file.open("user://names.json", File.WRITE)
	var defaults = Globals.default_names
	file.store_line(JSON.print(defaults, "\t"))
	file.close()
