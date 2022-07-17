extends Control

onready var scene = get_tree().get_current_scene()
onready var vbox = get_node("ScrollContainer/VBoxContainer")
var sprite_picker = load("res://UI/SpritePickerButton.tscn")
var color_picker_btn = load("res://UI/MyColorPickerButton.tscn")
var party_options
var settings
var party_count = 0
var name_nodes = []
var color_nodes = []
var voters_nodes = []
var asset_nodes = []

func _ready():
	settings = scene.load_settings()
	party_options = settings["parties"]
	scene.party_options = party_options

	var i = 0
	for p in party_options:
		var hbox2 = HBoxContainer.new()
		vbox.add_child(hbox2)
		
		var party_name = LineEdit.new()
		party_name.set_text(p)
		party_name.rect_min_size = Vector2(200,60)
		hbox2.add_child(party_name)
		name_nodes.append(party_name)
		hbox2.set_name("PartyName"+str(i))
		
		var cp = color_picker_btn.instance()
		var col_name = party_options[p]["color"]
		#var col_arr = settings["colors"][col_name]
		#var color = Color(col_arr[0], col_arr[1], col_arr[2])
		cp.rect_min_size = Vector2(60,60)
		hbox2.add_child(cp)
		cp.set_color(col_name)
		color_nodes.append(cp)
		
		var sp = sprite_picker.instance()
		sp.set_sprite(party_options[p]["asset"])
		hbox2.add_child(sp)
		asset_nodes.append(sp)
		
		var hbox = HBoxContainer.new()
		vbox.add_child(hbox)
		hbox.set_name("Voters"+str(i))
		
		var voters_label = Label.new()
		voters_label.set_text("Voters")
		hbox.add_child(voters_label)
		var spin_box = SpinBox.new()
		spin_box.value = party_options[p]["voters"]
		spin_box.rect_min_size = Vector2(200,60)
		spin_box.max_value = 99999999999
		hbox.add_child(spin_box)
		voters_nodes.append(spin_box)
		
		
		
		
		rect_min_size.y += 130
		party_count += 1
		
func get_textbox_name(index):
	return name_nodes[index].get_text()
	
func get_spinbox_voters(index):
	return voters_nodes[index].get_value()
	
func get_picker_color(index):
	return color_nodes[index].color
	
func get_asset(index):
	return asset_nodes[index].sprite.resource_path
