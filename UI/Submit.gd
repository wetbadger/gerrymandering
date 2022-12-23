extends Button


enum MODES {DISTRICT, PLACEMENT}
var mode = MODES.DISTRICT

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func switch_mode():
	match mode:
		MODES.DISTRICT:
			set_mode_placement()
		MODES.PLACEMENT:
			set_mode_district()
		_:
			print("This should not happen")
		
func set_mode_district():
	mode = MODES.DISTRICT
	text = "Count Votes"
	
func set_mode_placement():
	mode = MODES.PLACEMENT
	text = "Redistrict"

func _on_Submit_button_up():
	match mode:
		MODES.DISTRICT:
			get_tree().get_current_scene().submit()
		MODES.PLACEMENT:
			set_mode_district()
			get_tree().get_current_scene().submit_current_layout()
		_:
			print("This also should not happen")
