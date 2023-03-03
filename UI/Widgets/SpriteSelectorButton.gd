extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Control_button_up():
	#print(texture_normal.resource_path)
	#get_tree().get_current_scene().sprite_picker.texture_normal = texture_normal
	get_parent().get_parent().queue_free()
