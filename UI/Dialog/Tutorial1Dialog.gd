extends Dialog

func _ready():
	dialog_array = ["""
		These are your district buttons. Click one to select 
		a district to place.
		""",
		"""
		It doesn't matter which district goes where.
		"""]
	read_text_array(0)
