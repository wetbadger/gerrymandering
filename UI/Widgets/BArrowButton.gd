extends Button

enum {LEFT, RIGHT, UP, DOWN}

onready var left_texture = load("res://pics/ui/arrow-ios-back-outline.png")
onready var right_texture = load("res://pics/ui/arrow-ios-forward-outline.png")
onready var up_texture = load("res://pics/ui/arrow-ios-upward-outline.png")
onready var down_texture = load("res://pics/ui/arrow-ios-downward-outline.png")

export var direction = LEFT

func _ready():
	match direction:
		LEFT:
			icon = left_texture
		RIGHT:
			icon = right_texture
		UP:
			icon = up_texture
		DOWN:
			icon = down_texture
		_:
			icon = left_texture
	

func set_direction(dir):
	direction = dir
	match dir:
		LEFT:
			icon = left_texture
		RIGHT:
			icon = right_texture
		UP:
			icon = up_texture
		DOWN:
			icon = down_texture
		_:
			icon = left_texture
