extends TileMap


var example_map = [[40,30],[40,31]]


# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color(.1,.5,.2,1)
	for coord in example_map:
		set_cell(coord[0],coord[1],0)
		update_bitmask_area(Vector2(coord[0],coord[1]))
