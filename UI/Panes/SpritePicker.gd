extends Node2D

onready var assets = get_node("/root/Globals").default_settings["assets"]
onready var tilemap = get_node("SpriteTiles")

var button
var window
var width = 6

func _ready():
	generate()
	
func generate():
	var x = 1
	var y = 1

	for asset in assets:
		tilemap.set_cell(x, y, assets[asset])
		if x < width:
			x+=1
		else:
			x = 1
			y += 1

func set_window(w):
	window = w

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("click"):

		var local_mouse_position = get_local_mouse_position()
		var window_position = window.get_node("PanelContainer").get_global_position()
		var tile = Vector2(floor(local_mouse_position.x/18), floor(local_mouse_position.y/18))
		var index = (tile.x-1) + width * (tile.y-1)
		if index > 0 and index < len(assets):
			button.sprite_index = index
			button.change_sprite_index(tilemap, index)
			window.close_window()
		
func set_button(btn):
	self.button = btn
