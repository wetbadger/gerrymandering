extends OptionButton

func _ready():
	pass
	
func set_options(list):
	clear()
	if len(list) > 0 and list[0] != null:
		for opt in list:
			add_item(opt)
