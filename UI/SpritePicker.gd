extends Control

var sprite_picker = load("res://UI/SpritePicker.tscn")
var sprite

func _ready():
	pass
	
func set_sprite(path):
	var btn = get_node("Button")
	
	sprite = load(path)
	btn.texture_normal = sprite
	
func set_indexed_sprite(index):
	print(get_node("SpritePicker").sprites[index])


func _on_Button_button_up():
	var sp = sprite_picker.instance()
	get_tree().get_current_scene().add_child(sp)
