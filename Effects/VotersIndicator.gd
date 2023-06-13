extends Node2D

onready var square = load("res://Effects/IndicatorSquare.tscn")

var SPACING = 3
var count = 1
var previous_position
var number

func increment():
	var previous_position = get_children()[-1].get_global_position()
	count+=1
	set_num(count)
	return #remove this to show squares indicating voters
	
	var s = square.instance()
	add_child(s)
	var new_pos
	if count % 5 == 0:
		new_pos = Vector2(previous_position.x - SPACING * 4, previous_position.y + SPACING)
	else:
		new_pos = Vector2(previous_position.x + SPACING, previous_position.y)
	s.set_global_position(new_pos)
	previous_position = new_pos
	

func set_num(n):
	number = n
	get_node("Label").text = str(n)
	return #remove this to show squares indicating voters
	
	var pos = $IndicatorSquare.get_global_position()
	previous_position = pos
	var i = 0
	var k = 0
	while k < n-1:
		var s = square.instance()
		add_child(s)
		if i >= 4:
			previous_position = Vector2(pos.x - SPACING, previous_position.y + SPACING)
			i = -1
			
		s.set_global_position(Vector2(previous_position.x + SPACING, previous_position.y))
		previous_position = s.get_global_position()
		count += 1

		i+=1
		k+=1
