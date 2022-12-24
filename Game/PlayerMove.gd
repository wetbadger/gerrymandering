extends Control

onready var sprite = $Sprite
onready var label = $BLabel
var sprite_index = 0
var tiles = preload("res://Objects/Tiles/SpriteTiles2.tres")

func set_sprite(sprite):
	var index
	if typeof(sprite) == TYPE_INT or typeof(sprite) == TYPE_REAL:
		#don't know why sprite is sometimes set to a REAL ...
		index = Globals.default_settings["assets"].values()[sprite]
		sprite_index = int(sprite)
	else: #probably a string
		index = Globals.default_settings["assets"][sprite]
		sprite_index = index
	var texture = tiles.tile_get_texture(index)
	var region_rect = tiles.tile_get_region(sprite_index)

	var atlas_texture = AtlasTexture.new()
	atlas_texture.set_atlas(texture)
	atlas_texture.set_region(region_rect)
	get_node("Sprite").set_texture(atlas_texture)
	
func set_label(text):
	label.text = text
	
func set_party(_name, info):
	set_label(_name)
	set_sprite(info["asset"])