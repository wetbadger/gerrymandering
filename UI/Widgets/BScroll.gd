extends ScrollContainer

onready var scene = get_tree().get_current_scene()

func _ready():
	pass
	#connect_signals()
	
#func connect_signals():
#	connect("scroll_started", self, "_on_Scroll_scroll_started")
#	connect("scroll_ended", self, "_on_Scroll_scroll_ended")


func _on_Scroll_scroll_started():
	scene.get_node("State/Camera2D").set_can_zoom(false)


func _on_Scroll_scroll_ended():
	scene.get_node("State/Camera2D").set_can_zoom(true)

