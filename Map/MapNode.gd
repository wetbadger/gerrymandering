extends Node2D

export var folder = "lvl1"
onready var start_btn = $"../../ButtonContainer/HBox/Start2"

onready var scene = get_tree().get_current_scene()

var settings = {}
var matrix = {}
var pointers = []

var disabled = false

func _ready():
	# code would look like this if we wanted to load from a file
	# but HTML would need cookies
#	var file = File.new()
#	file.open("user://"+folder+"/settings.json", File.READ)
#	self.settings = parse_json(file.get_as_text())
	
#	file.open("user://"+folder+"/matrix.json", File.READ)
#	self.matrix = parse_json(file.get_as_text())
#	file.close()
#	self.pointers = settings["pointer"]
	match folder:
		"lvl1":
			self.settings = Levels.lvl1
			self.matrix = Levels.lvl1_mtrx
		"lvl2":
			self.settings = Levels.lvl2
			self.matrix = Levels.lvl2_mtrx
		_:
			print("No such level.")
			return
			
	self.pointers = settings["pointer"]

func set_settings(_settings):
	self.settings = _settings
	
func set_matrix(_matrix):
	self.matrix = _matrix
	
func set_pointers(_pointers):
	self.pointers = _pointers
	#animate additional pointers
	
func disable():
	disabled = true
	modulate = Color(0.1,0.1,0.1,0.8)

func _on_Button_button_up():
	$Click.play()
	start_btn.set_process(true)
	scene.current_selection = self
