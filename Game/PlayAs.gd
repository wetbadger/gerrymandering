extends Node2D

onready var control = $Control
onready var tilemap = $Control/SpriteTiles3

func _ready():
	set_process(true)

func _process(_delta):
	if control.rect_scale.x < 1:
		control.rect_scale = Vector2(
			control.rect_scale.x + 0.02, 
			control.rect_scale.y + 0.02
		)
	if modulate[3] < 1:
		modulate[3] += 0.02

func set_player(asset):
	tilemap.set_cell(2, 0, asset)


func _on_Button_button_up():
	queue_free()
