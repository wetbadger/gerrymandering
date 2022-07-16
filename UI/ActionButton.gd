extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_button_up():
	var scene = get_tree().get_current_scene()
	var flood = scene.get_node("Flood")
	var matrix = scene.matrix.vertices
	var childs = scene.get_children()
	print(childs)
	for s in flood.squares:
		matrix[s]["visited_empty"] = false
		matrix[s].erase("district")
	flood.queue_free()
	var x = get_tree().get_current_scene().matrix.vertices

