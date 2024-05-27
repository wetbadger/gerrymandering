extends Node2D

onready var control = $Control
onready var tilemap = $Control/SpriteTiles3
onready var color_rect = $ColorRect
onready var player_color = $Control/ColorRect

enum {GROW, SHRINK, DONE}

var mode = GROW
var i = 0
var color_rect_freed = false

var Y_POS = 30

signal finished

func _ready():
	pass

func _process(_delta):
	if mode != DONE:
		if mode == GROW:
			if control.rect_scale.x < 1:
				control.rect_scale = Vector2(
					control.rect_scale.x + 0.04, 
					control.rect_scale.y + 0.04
				)
			else:
				#yield(get_tree().create_timer(1.0), "timeout")
				if i >= 20:
					mode = SHRINK
				i+=1
				
			if modulate[3] < 1:
				modulate[3] += 0.02
			
		if mode == SHRINK:
			var pos = control.get_global_position()
			if not color_rect_freed and color_rect.modulate[3] > 0 or control.rect_scale.x > 0.1 or pos.y > Y_POS:
				if control.rect_scale.x > 0.1:
					control.rect_scale = Vector2(
						control.rect_scale.x - 0.02, 
						control.rect_scale.y - 0.02
					)
				if not color_rect_freed and color_rect.modulate[3] > 0:
					color_rect.modulate[3] -= 0.03
				else:
					free_color_rect()
					
				if pos.y > Y_POS:
					control.set_global_position(Vector2(pos.x, pos.y-10))
			else:
				mode = DONE
				emit_signal("finished")
				if not color_rect_freed: #race condition
					free_color_rect()
				set_process(false)
				

func set_player(asset):
	tilemap.set_cell(2, 0, asset)

func free_color_rect():
	if not color_rect_freed:
		color_rect.queue_free()
		color_rect_freed = true

func set_color(c):
	player_color.color = c

func _on_Button_button_up():
	queue_free()
