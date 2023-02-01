extends Node2D

onready var assets = get_node("/root/Globals").default_settings["assets"]
#onready var tilemap = get_node("SpriteTiles2")
var tilemap = load("res://Objects/Tiles/SpriteTiles3.tscn")
var bSpriteSelectorButton = load("res://UI/Widgets/BSpriteSelectorButton.tscn")

var button
var window
var width = 12

onready var grid = get_node("Scroll/GridContainer")

var buttons = []

func _ready():
	generate()
	
func generate():
	var x = 1
	var y = 1
	var tm = tilemap.instance()
	
	
	for asset in assets:
		var bssb = bSpriteSelectorButton.instance()
		grid.add_child(bssb)
		bssb.set_tile(tilemap, assets[asset])
		bssb.set_window(window)
		bssb.set_button(button)
		buttons.append(bssb)

#	for asset in assets:
#		tilemap.set_cell(x, y, assets[asset])
#		if x < width:
#			x+=3
#		else:
#			x = 1
#			y += 3

func set_window(w):
	window = w

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("click"):
		button.set_original_sprite_index(button.sprite_index)
		window.close_window()
		
func set_button(btn):
	self.button = btn
