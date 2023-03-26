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
	return Globals.default_names
	
func create_name_file():
	var file = File.new()
	file.open("user://names.json", File.WRITE)
	var defaults = Globals.default_names
	file.store_line(JSON.print(defaults, "\t"))
	file.close()
