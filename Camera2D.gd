extends Camera2D

#TODO: save zoom level and position after closing

var zoom_min = Vector2(0.05, 0.05)
var zoom_max = Vector2(1, 1)
var zoom_speed = Vector2(.05, .05)
var zoom_factor = Vector2(0.0,0.0) #change in zoom speed
var zoom_speed_min = Vector2(0.01,0.01)
var zoom_speed_max = Vector2(0.2, 0.2)

var left_max = 0
var right_max
var top_max = 0
var bottom_max
var rect

var can_zoom = true

onready var zoom_debug_label = get_tree().get_current_scene().get_node("UI/Debug/HBox/ZoomLabel")
# Called when the node enters the scene tree for the first time.
func _ready():
	current = true
	rect = get_viewport_rect()
	set_global_position(rect.size / 2)
	#set_zoom(Vector2(0.5, 0.5)) 
	right_max = rect.size.x
	bottom_max = rect.size.y


func _input(event):
	if can_zoom:
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

				#zoom out
				if event.button_index == BUTTON_WHEEL_DOWN:
					if zoom + zoom_speed < zoom_max:
						zoom += zoom_speed
					else:
						zoom = zoom_max
						
					if zoom_speed < zoom_speed_max:
						zoom_speed += zoom_factor
						
				if not event.button_index == BUTTON_LEFT:
					#do some thing here or not, whatever man
					pass
					
				zoom_debug_label.text = str(zoom.x)
					
		if event is InputEventKey:
			if event.is_pressed():
				var pos = get_global_position()
				var key = OS.get_scancode_string(event.physical_scancode)
				match key:
					"Left", "A":
						set_global_position(Vector2(pos.x - 6, pos.y))
					"Right", "D":
						set_global_position(Vector2(pos.x + 6, pos.y))
					"Up", "W":
						set_global_position(Vector2(pos.x, pos.y-6))
					"Down", "S":
						set_global_position(Vector2(pos.x, pos.y+6))
		
func set_can_zoom(torf):
	can_zoom = torf		
			
func _unhandled_input(event):
	if event == InputEventMouseMotion:
		if event.button_mask == BUTTON_MASK_MIDDLE:
			position -= event.relative * zoom
