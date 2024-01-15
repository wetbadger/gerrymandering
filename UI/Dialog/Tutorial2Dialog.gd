extends Dialog

onready var arrow = get_node("../FlashingArrow2")
onready var scene = get_tree().get_current_scene()

var current_text = "..."

var mouse_up = false # mouse is in up position

func _ready():
	set_process(false)
	event_based = true
	dialog_array = [
		"""...""",
		"""Now is a good time to explain the UI.
		""",
		"""This tells us the population size and how many
voters have been placed in a district.
		""",
		"""This tells us who we're playing as, in case you 
forget whose side you're on...
		""",
		"""This tells us how many districts need to be the
minimum size. Here, we can see that two districts 
should have one less voter than the others.""",
		"""The menu is over here is case you want to quit.""",
		"""I'll let you figure out the rest!"""]
	current_text = dialog_array[dialog_index]
	$DialogBox.set_text(current_text)

func next():
	if dialog_index >= len(dialog_array)-1:
		dialog_index-=1
		return

	dialog_index+=1
	
	current_text = dialog_array[dialog_index]
	$DialogBox.set_text(current_text)
	if dialog_index == 1:
		var pos = scene.progress_label.get_global_position()
		arrow.set_global_position(Vector2(pos.x, pos.y + 30))
		arrow.rotate(3.14/2)
	if dialog_index == 2:
		arrow.visible = true
	if dialog_index == 3:
		var pos = scene.play_as.get_node("Control").get_global_position()
		arrow.set_global_position(Vector2(pos.x, pos.y + 30))
	if dialog_index == 4:
		var pos = scene.min_ticker.get_node("MinTickerLabel").get_global_position()
		arrow.set_global_position(Vector2(pos.x, pos.y + 30))
	if dialog_index == 5:
		var pos = scene.in_game_menu_button.get_global_position()
		arrow.set_global_position(Vector2(pos.x + 25, pos.y + 30))
	if dialog_index == 6:
		scene.disable_draw = false
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
	
func set_to(index):
	dialog_index = index
	next()
	
func _input(event):
	if (event is InputEventKey or event is InputEventScreenTouch):
		mouse_up = !mouse_up
		if !mouse_up:
			next()
		
