extends Dialog

func _ready():
	nodes = [$"../../Container/lvl1"]
	if Globals.map_progress["Tutoria"]["lvl2"] == false:
		dialog_array = ["""
		This is the island of Tutoria! Here, we aren't the most 
		popular party, but that doesn't mean we can't win  
		""",
		"""
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
		districts need to be 1 voter smaller than the others.
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
		"""]
		read_text_array(dialog_index)
		#state = 3
