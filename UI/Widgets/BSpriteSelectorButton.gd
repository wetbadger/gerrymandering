extends Button


onready var tilemap = get_node("Container/SpriteTiles3")
var corresponding_button
var window
var tile_num

func _ready():
	pass

func set_button(btn):
	corresponding_button = btn
	
func set_window(w):
	window = w

func set_tile(_tm, num):
	tile_num = num
	tilemap.set_cell(0, 0, num)


func _on_Container_mouse_entered():
	corresponding_button.change_sprite_index(tilemap, tile_num)


func _on_Container_mouse_exited():
	corresponding_button.change_sprite_index(tilemap, corresponding_button.original_sprite_index)
