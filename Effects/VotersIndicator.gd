extends Node2D

onready var square = load("res://Effects/IndicatorSquare.tscn")

var SPACING = 2.5

func set_num(n):
	var i = 0
	var pos = $IndicatorSquare.get_global_position()
	var previous_position = pos
	while i < n-1:
		var s = square.instance()
		add_child(s)
		s.set_global_position(Vector2(previous_position.x + SPACING, previous_position.y))
		previous_position = s.get_global_position()
		i+=1
