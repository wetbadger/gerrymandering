extends Node2D


onready var head = load("res://UI/PersonIcon.tscn")

var SPACING = 20

var extra_heads = []

func set_num(n):
	var i = 0
	var pos = $PersonIcon.get_global_position()
	var previous_position = pos
	if len(extra_heads) != n:
		for h in extra_heads:
			h.queue_free()
		extra_heads = []
		while i < n-1:
			var s = head.instance()
			extra_heads.append(s)
			add_child(s)
			s.set_global_position(Vector2(previous_position.x + SPACING, previous_position.y))
			previous_position = s.get_global_position()
			i+=1
