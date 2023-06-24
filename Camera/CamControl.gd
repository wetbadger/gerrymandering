extends Camera2D

# Special controls for touch screens
# https://www.youtube.com/watch?v=duDk9ICkKWI
onready var scene = get_tree().get_current_scene()
onready var camera = scene.get_node("State/Camera2D")

var _touches = {}
var _touches_info = {"num_touch_last_frame":0, "radius":0, "total_pan":0}
var _debug_cur_touch = 0
var z_held = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_touch_info():
	if _touches.size() <= 0:
		_touches_info.num_touch_last_frame = _touches.size()
		_touches_info["total_pan"] = 0
		return
	
	var avg_touch = Vector2(0,0)
	for key in _touches:
		avg_touch += _touches[key].current.position
	_touches_info["cur_pos"] = avg_touch / _touches.size()
	if _touches_info.num_touch_last_frame != _touches.size():
		_touches_info["target"] = _touches_info["cur_pos"]
		
	_touches_info.num_touch_last_frame = _touches.size()
	
	do_multitouch_pan()
	
func do_multitouch_pan():
	var diff = _touches_info.target - _touches_info.cur_pos
	
	var new_pos = camera.position + (camera.zoom.x * diff)
	
	var bounds #TODO set bounds

	_touches_info["total_pan"] += (camera.position - new_pos).length()

	camera.position = new_pos
	_touches_info.target = _touches_info.cur_pos

func _unhandled_input(event):
	if scene.disable_draw and scene.can_move:
		#handle multi-touch from capapable devices
		if event is InputEventScreenTouch and event.pressed == true:
			_touches[event.index] = {"start": event, "current": event}
		if event is InputEventScreenTouch and event.pressed == false:
			_touches.erase(event.index)
		if event is InputEventScreenDrag:
			_touches[event.index]["current"] = event
			
		pretend_multi_touch(event)
	
	

func pretend_multi_touch(event):
	if scene.settings["advanced"]["Other"]["debug"]:
		if event is InputEventKey and event.scancode == KEY_X:
			_touches = {}
			_touches_info = {"num_touch_last_frame":0, "radius":0, "total_pan":0}
			
		if event is InputEventKey and event.scancode == KEY_Z:
				
			if event.pressed:
				z_held = true
				if _debug_cur_touch == 0:
					_debug_cur_touch = 1
			else:
				z_held=false
				if _debug_cur_touch == 1:
					_debug_cur_touch = 0
				
	if event is InputEventMouseButton:
		if event.pressed:
			if z_held:
				var pos = event.get_position()
				
				event = InputEventScreenTouch.new()
				event.position = pos
				event.pressed = true
				
			_touches[_debug_cur_touch] = {"start":event, "current":event}
		else:
			_touches.erase(_debug_cur_touch)		
	if event is InputEventMouseMotion:
		if _debug_cur_touch in _touches:
			_touches[_debug_cur_touch]["current"] = event
			
	var err_str = "("
	var comma = ""
	for touch in _touches.values():
		err_str += comma + str(touch.current.position)
		comma = ","
	err_str+=")"
	scene.error_label.text = err_str
	
	update_touch_info()
	update_pinch_gesture()
	

func update_pinch_gesture():
	if _touches.size() < 2:
		_touches_info["radius"] = 0
		_touches_info["previous_radius"] = 0
		return
		
	_touches_info["previous_radius"] = _touches_info["radius"]
	_touches_info["radius"] = (_touches.values()[0].current.position - _touches_info["target"]).length()
	
	if _touches_info["previous_radius"] == 0:
		return
		
	var zoom_factor = (_touches_info["previous_radius"] - _touches_info["radius"]) / _touches_info["previous_radius"]
	var final_zoom = camera.zoom.x + (zoom_factor)
	
	camera.zoom = Vector2(final_zoom,final_zoom)
	camera.zoom.x = clamp(camera.zoom.x, camera.zoom_min.x, camera.zoom_max.x) #x and y should be same
	camera.zoom.y = clamp(camera.zoom.y, camera.zoom_min.x, camera.zoom_max.x)
	
	#str(_touches.values()[0].current)+", "+str(str(_touches.values()[1].current))

	var vp_size = camera.get_viewport().size
	if get_viewport().is_size_override_enabled():
		vp_size = get_viewport().get_size_override()
	var old_dist = ((_touches_info["target"] - (vp_size / 2.0))*(camera.zoom-Vector2(zoom_factor, zoom_factor)))
	var new_dist = ((_touches_info["target"] - (vp_size / 2.0))*camera.zoom)
	var cam_need_move = old_dist - new_dist
	camera.position += cam_need_move
