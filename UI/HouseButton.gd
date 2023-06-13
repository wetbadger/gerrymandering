extends Button

var sprite_index
var party_name
var voters
var label
var type = "house"
onready var scene = get_tree().get_current_scene()

func set_sprite(sprite, tilemap):
	var index
	if typeof(sprite) == TYPE_INT or typeof(sprite) == TYPE_REAL:
		#don't know why sprite is sometimes set to a REAL ...
		index = Globals.default_settings["assets"].values()[sprite]
		sprite_index = int(sprite)
	else: #probably a string
		index = Globals.default_settings["assets"][sprite]
		sprite_index = index
	var texture = tilemap.tile_set.tile_get_texture(index)
	var region_rect = tilemap.tile_set.tile_get_region(sprite_index)

	var atlas_texture = AtlasTexture.new()
	atlas_texture.set_atlas(texture)
	atlas_texture.set_region(region_rect)
	get_node("Sprite").set_texture(atlas_texture)

func unselect_house(house_name):
	var state = get_tree().get_current_scene().get_node("State")
	if state.has_node(house_name):
		state.get_node(house_name).is_selected = false
		
func decrement_voters(n=1):
	voters -= n
	label.set_text(party_name + "\n" + str(voters))

func increment_voters(n=1):
	voters += n
	label.set_text(party_name + "\n" + str(voters))

func _on_HouseButton_button_up():
	get_tree().set_input_as_handled()
	var buttons = get_tree().get_nodes_in_group("house_buttons")
	for b in buttons:
		if b != self:
			b.pressed = false
			unselect_house(b.name)
	get_parent().gap_button.pressed = false
			
	scene.selected_house = self
