extends Button


enum MODES {DISTRICT, PLACEMENT, MULTIPLAYER}
var mode = MODES.DISTRICT
var reason = "Not all houses are in a district."
onready var scene = get_tree().get_current_scene()
onready var tooltip = $BLabel

onready var district_buttons = scene.get_node("UI/Scroll/DistrictButtons")

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
	reason = "Not all houses are in a district."
	
func set_mode_placement():
	mode = MODES.PLACEMENT
	text = "Redistrict"
	reason = "Not all houses are placed."
	
func set_mode_multiplayer():
	mode = MODES.MULTIPLAYER
	text = "End Turn"
	reason = "District must have more voters."
	
func set_reason(string):
	reason = string
	
func get_reason():
	return reason

func _on_Submit_button_up():
	match mode:
		MODES.DISTRICT:
			scene.submit()
		MODES.PLACEMENT:
			if !scene._multiplayer:
				set_mode_district()
			else:
				set_mode_multiplayer()
				disabled = true
			scene.submit_current_layout()
		MODES.MULTIPLAYER:
			disabled = true
			for btn in district_buttons.get_children():
				if btn.pressed:
					btn.turn_ended = true
					print("button "+btn.name+" turn ended")
			scene.increment_player()
			#scene.get_node(scene.selected_district).turn_ended = true
			
		_:
			print("This also should not happen")


func show_tip():
	tooltip.text = reason
	tooltip.visible = true
