extends Button

#Start2 is not Start

# This script was created as a simpler version of start
# to start a game already loaded from a map node.

onready var scene = get_tree().get_current_scene()
onready var music = scene.get_node("MapTheme")

var alpha = 0
var button_up = false

func _ready():
	set_process(false)

func _process(_delta):
	modulate = Color(alpha,alpha,alpha,alpha)
	if alpha <= 1.0:
		alpha += 0.05
	
	if button_up:
		music.volume_db -= 1
		if music.volume_db <= -50:
			var error = get_tree().change_scene("res://Game/main.tscn")
			if error:
				print("Could not load main scene")


func _on_Start2_button_up():
	#TODO: cool animation
	Globals.current_settings = scene.current_selection.settings
	#change the lists to single fields
	Globals.current_settings["advanced"]["House Placement"]["layout"] = scene.current_selection.settings["advanced"]["House Placement"]["layout"][0]
	Globals.current_settings["advanced"]["House Placement"]["algorithm"] = scene.current_selection.settings["advanced"]["House Placement"]["algorithm"][0]
	button_up = true
