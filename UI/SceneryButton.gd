extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var sprite = get_node("Sprite")
onready var picker = get_node("ColorPickerButton")
export var color = Color(.1,.5,.2,1)
export var layer = 0
onready var scene = get_tree().get_current_scene()

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.modulate = color
	if picker:
		picker.color = color


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SceneryButton_button_up():
	scene.terrain_layer = scene.terrain_layers[layer]
	var buttons = self.get_parent().get_children()
	for b in buttons:
		if b != self:
			b.pressed = false
	self.pressed = true


func _on_ColorPickerButton_color_changed(c):
	sprite.modulate = c
	scene.terrain_layers[layer].modulate = c
	color = c
