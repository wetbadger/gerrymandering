extends Dialog

onready var arrow = get_node("../FlashingArrow")
onready var scene = get_tree().get_current_scene()

func _ready():
	event_based = true
	dialog_array = [
		"""...""",
		"""These are your district buttons. Click one to select 
a district to place.""",
		"""It doesn't matter which district goes where.""",
		"""Now, click on a house to declare as part of the
district."""]
	$Dialog.set_text(dialog_array[dialog_index])

func next():
	dialog_index+=1
	$Dialog.set_text(dialog_array[dialog_index])
	if dialog_index == 1:
		arrow.visible = true
		var pos = scene.district_buttons.get_global_position()
		arrow.set_global_position(Vector2(pos.x, pos.y + 100))
		arrow.rotate(3.14)
	if dialog_index == 2:
		event_based = false
		arrow.visible = false
		
