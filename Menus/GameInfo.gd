extends Control

func set_party(party, color, voters):

	var p = Label.new()
	p.text = party
	get_node("GridContainer").add_child(p)
	
	var c = Globals.word2color(color)
	var cr = ColorRect.new()
	cr.rect_size = Vector2(40, 40)
	cr.color = c
	get_node("GridContainer").add_child(cr)
	
	var v = Label.new()
	v.text = str(voters)
	get_node("GridContainer").add_child(v)
