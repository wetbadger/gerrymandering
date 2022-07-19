extends Picker

onready var colors = get_node("/root/Globals").default_settings["colors"]
onready var ColorSquare = load("res://UI/Icons/ColorSquare.tscn")

var button

func _ready():
	for c in colors:
		var square = ColorSquare.instance()
		var col_arr = colors[c]
		var color = Color(col_arr[0],col_arr[1],col_arr[2])
		square.color = color
		square.rect_min_size = Vector2(100, 100)
		square.set_button(button)
		insert(square)

func set_button(button):
	self.button = button
