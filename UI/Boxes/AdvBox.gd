extends Pane


onready var vbox = get_node("VBox")

func _ready():
	is_read_only = true
	
func set_read_only(boolean): #instances not calling ready for some reason?
	is_read_only = boolean
