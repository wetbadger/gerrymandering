extends Dialog

func _ready():
	nodes = [$"../../Container/lvl1"]
	if Globals.map_progress["Tutoria"]["completed"] == true:
		queue_free()
		
	if Globals.map_progress["Tutoria"]["lvl2"] == false:
		dialog_array = ["""
		This is the island of Tutoria! Here, we aren't the most 
		popular party, but that doesn't mean we can't win 
		more seats in the Chamber of Legislation! 
		""",
		"""
		To start riggin', click on the state indicated by 
		the flashing arrow.
		"""
		]
		read_text_array(dialog_index)
		#state = 1
	elif Globals.map_progress["Tutoria"]["lvl3"] == false:
		dialog_array = ["""
		Ideally, every district is the same size but this 
		isn't always possible.  
		""",
		"""
		This district has 28 people and 5 districts, so 2
		districts need to 1 less voter than the others.
		Because math.
		""",
		"""
		Let's see if we can use this to our advantage.
		"""
		]
		read_text_array(dialog_index)
		#state = 2
	else:
		dialog_array = ["""
		Some places have more people than others.
		""",
		"""
		In this next area, pay special attention to the 
		number of voters on each square.
		""",
		"""
		Oh, yeah. Also there is a third party... mere
		pawns in our game of thrones.
		"""]
		read_text_array(dialog_index)
		#state = 3

func press_start():
	dialog_array = ["""
		Now press the big red start button at the
		top of your window.
		"""]
	read_text_array(0)
