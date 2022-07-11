extends Camera2D


var zoom_min = Vector2(0.05, 0.05)
var zoom_max = Vector2(1, 1)
var zoom_speed = Vector2(.2, .2)
var zoom_factor = Vector2(0.01,0.01)
var zoom_speed_min = Vector2(0.01,0.01)
var zoom_speed_max = Vector2(0.2, 0.2)

# Called when the node enters the scene tree for the first time.
func _ready():
	current = true
	set_global_position(get_viewport_rect().size / 2)
	set_zoom(zoom_max)


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			#zoom in
			if event.button_index == BUTTON_WHEEL_UP:
				#if zoom > zoom_min:
				if zoom - zoom_speed > zoom_min:
					zoom -= zoom_speed
				else:
					zoom = zoom_min
					
				if zoom_speed > zoom_speed_min:
					zoom_speed -= zoom_factor
				print(zoom)

			#zoom out
			if event.button_index == BUTTON_WHEEL_DOWN:
				if zoom + zoom_speed < zoom_max:
					zoom += zoom_speed
				else:
					zoom = zoom_max
					
				if zoom_speed < zoom_speed_max:
					zoom_speed += zoom_factor
					
				print(zoom)

