extends Control

var window = load("res://UI/Classes/Window.tscn")
var bSpritePicker = load("res://UI/Panes/SpritePicker.tscn")

var sprite
var sprite_index

func _ready():
	pass

func set_sprite(sprite_name):
	sprite = sprite_name
	
func set_sprite_index(tilemap):
	var index = Globals.default_settings["assets"][sprite]
	sprite_index = index
	var texture = tilemap.tile_set.tile_get_texture(index)
	var region_rect = tilemap.tile_set.tile_get_region(sprite_index)
	var atlas_texture = AtlasTexture.new()
	atlas_texture.set_atlas(texture)
	atlas_texture.set_region(region_rect)
	get_node("Sprite").set_texture(atlas_texture)
	
func change_sprite_index(tilemap, index):
	var texture = tilemap.tile_set.tile_get_texture(index)
	var region_rect = tilemap.tile_set.tile_get_region(sprite_index)
	var atlas_texture = AtlasTexture.new()
	atlas_texture.set_atlas(texture)
	atlas_texture.set_region(region_rect)
	get_node("Sprite").set_texture(atlas_texture)



func _on_Button_button_up():
	var w = window.instance()
	
	w.set_title("Sprite Picker")
	
	var bs = bSpritePicker.instance()
	bs.set_button(self)
	
	position_window(w)

	get_tree().get_current_scene().add_child(w)
	
	w.add_element(bs, 5)
	bs.set_window(w)
	
func position_window(w):
	var viewport = get_viewport()
	var mouse_pos = get_global_mouse_position()

	var new_pos
	if mouse_pos.x >= viewport.size.x / 2:
		new_pos = Vector2(mouse_pos.x - 50, mouse_pos.y)
	elif mouse_pos.x < viewport.size.x / 2:
		new_pos = Vector2(mouse_pos.x + 50, mouse_pos.y)
		
	if mouse_pos.y >= viewport.size.y / 2:
		new_pos.y -= 50
	elif mouse_pos.y < viewport.size.y / 2:
		new_pos.y += 50
		
	w.set_global_position(new_pos)
