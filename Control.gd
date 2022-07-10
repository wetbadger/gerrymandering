extends Control

var _pen = null
var _prev_mouse_pos = Vector2()


func _ready():
	# Create the viewport
	var viewport = Viewport.new()
	# Make it so it renders on a texture
	#viewport.set_as_render_target(true)
	# Set the size of it
	var rect = get_rect()
	viewport.size = Vector2(rect.size.x, rect.size.y)

	# I tried to set the background color, but none of this worked...
#   var world = World.new()
#   var env = Environment.new()
#   env.set_background(Environment.BG_COLOR)
#   env.set_background_param(Environment.BG_PARAM_COLOR, Color(0,0,0))
#   world.set_environment(env)
#   viewport.set_world(world)
#   viewport.set_use_own_world(true)

	_pen = Node2D.new()
	viewport.add_child(_pen)
	_pen.connect("draw", self, "_on_draw")

	# Don't clear the frame when it gets updated so it will accumulate drawings
	#viewport.set_render_target_clear_on_new_frame(false)

	add_child(viewport)

	# Use a TextureFrame to display the result texture (because pivot is top-left)
	var rt = viewport.get_texture()
	var board = TextureRect.new()
	board.set_texture(rt)
	add_child(board)

	set_process(true)


func _process(delta):
	_pen.update()


func _on_draw():
	var mouse_pos = get_local_mouse_position()

	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		_pen.draw_line(mouse_pos, _prev_mouse_pos, Color(1, 1, 0))

	_prev_mouse_pos = mouse_pos
