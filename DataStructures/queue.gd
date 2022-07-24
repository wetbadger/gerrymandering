extends Node

var arr = []

func _ready():
	pass
	
func set_array(array):
	arr = array

func enqueue(elem):
	arr.append(elem)
	
func dequeue():
	return arr.pop_at(0)
	
func empty():
	if len(arr) == 0:
		return true
	return false
