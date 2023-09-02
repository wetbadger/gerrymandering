extends Dialog

onready var arrow = get_node("../FlashingArrow")
onready var scene = get_tree().get_current_scene()

var current_text = "..."

var broken = false
var mouse_up = false # mouse is in up position

func _ready():
	set_process(false)
	event_based = true
	dialog_array = [
		"""...""",
		"""These are your district buttons. Click one to select 
a district to place.
		""",
		"""It doesn't matter which district goes where.
Click on a house and you will declare it as part of
a district.
		""",
		"""Awesome! Now draw a contiguous shape. That's
a fancy word for a shape that is less than 2 shapes. 
(Consult manual if still confused.)
		""",
		"""Good job! You filled in a district. See if you can
fill in the whole state!""",
		"""Good job! That's 2 districts! The last one should
be easy.""",
		"""You did it! Now we count the votes!
		"""]
	current_text = dialog_array[dialog_index]
	$DialogBox.set_text(current_text)

func next():
	if dialog_index >= len(dialog_array):
		dialog_index-=1
		return
	if broken == false:
		dialog_index+=1
	current_text = dialog_array[dialog_index]
	$DialogBox.set_text(current_text)
	if dialog_index == 1:
		arrow.visible = true
		var pos = scene.district_buttons.get_global_position()
		arrow.set_global_position(Vector2(pos.x, pos.y + 100))
		arrow.rotate(3.14)
	if dialog_index == 2:
		arrow.visible = false
		scene.disable_draw = false
	if dialog_index == 6:
		mouse_filter = Control.MOUSE_FILTER_IGNORE
		yield(get_tree().create_timer(1.5), "timeout")
		set_process(true)
		yield(get_tree().create_timer(1.5), "timeout")
		get_parent().queue_free()

func prev():
	dialog_index-=1

func _process(_delta):
	if modulate.a > 0.0:
		modulate.a -= 0.02

func filled():
	next()
	
func unfilled():
	prev()
	
func set_to(index):
	dialog_index = index
	next()

func broken():
	broken = true
	current_text = """Oh no! You broke it! Don't panic! When you see
the broken puzzle piece on the button, that just
means your district is not contiguous."""
	$DialogBox.set_text(current_text)
	if dialog_index < len(dialog_array) - 1:
		scene.disable_draw = true
	
func unbroken():
	scene.disable_draw = false
	broken = false
	current_text = """Good job! You made your district contiguous
again! You can do this by erasing or reconnecting
to consolidate disparate components."""
	$DialogBox.set_text(current_text)
	
func new_district():
	if dialog_index == 1:
		next()

func _unhandled_input(event):
	if (event is InputEventKey or event is InputEventScreenTouch):
		mouse_up = !mouse_up
		if dialog_index == 2:
			pass
			#next()
		if broken and not mouse_up and not $DialogBox.writing:
			current_text = """Try erasing some of your extra pieces by right 
clicking on a colored square.
"""
			$DialogBox.set_text(current_text)
			scene.disable_draw = false
		
