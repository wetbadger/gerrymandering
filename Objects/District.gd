extends Node2D

var color = Color(1, 1, 1)
var highlight = load("res://Objects/Highlight.tscn")
var starting_vertex
var max_size = 0
var house_count = 0

func _ready():
	pass # Replace with function body.

func set_starting_vertex(vertex):
	starting_vertex = vertex

func highlight(grid_point):
	
	var house_id = str(grid_point.x*grid_point.y)
	var matrix = get_tree().get_current_scene().matrix.vertices
	if max_size > house_count:
		if matrix.has(house_id):
			if not matrix[house_id].has("district"):
				matrix[house_id]["district"] = self.name
				var cell = (grid_point-starting_vertex)
				var tm = get_node("TileMap")
				var id = tm.get_cell(cell.x, cell.y)
				tm.get_tileset().create_tile(cell.x* cell.y)
				#this cannot be easily tracked
#				var highlight_new = highlight.instance()
#				highlight_new.set_position(grid_point*6-starting_vertex*6)
#				add_child(highlight_new) 
				if matrix[house_id]["type"] == "House":
					house_count+=1
					
func erase(grid_point):
	var house_id = str(grid_point.x*grid_point.y)
	var matrix = get_tree().get_current_scene().matrix.vertices
	if matrix.has(house_id):
		if matrix[house_id].has("district"):
			matrix[house_id].erase("district")
			#TODO: unhighlight grid
