extends Node2D

onready var square = load("res://Effects/IndicatorSquare.tscn")

var SPACING = 3

func set_num(n):
	var pos = $IndicatorSquare.get_global_position()
	var previous_position = pos
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

		i+=1
		k+=1
