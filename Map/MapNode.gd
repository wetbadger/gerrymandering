extends Node2D

export var folder = "lvl1"
onready var start_btn = $"../../ButtonContainer/HBox/Start2"

onready var scene = get_tree().get_current_scene()
onready var dialog = get_node("../../Dialog/SallyDialog")

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

	self.settings = Levels.settings[folder]
	self.matrix = Levels.matrices[folder]
			
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
	visible = false
	
func enable():
	disabled = false
	visible = true

func _on_Button_button_up():
	$Click.play()
	start_btn.set_process(true)
	scene.current_selection = self
	dialog.press_start()
