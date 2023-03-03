extends KinematicBody2D

onready var sprite = get_node("Sprite")

var color = "white"
var party = ""
onready var max_scale = get_parent().max_scale

func _ready():
	scale = Vector2(0,0)

func set_color(col):
	color = col
	var color_obj = Globals.word2color(col)
	sprite.modulate = color_obj

func _physics_process(delta):
	move_and_slide(Vector2(0,0))
	if scale.x < max_scale:
		scale+= Vector2(0.004, 0.004)
