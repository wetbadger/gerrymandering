extends TileMap


var map = [[40,30],[41,31]]

export var color = Color(.1,.5,.2,1) #a default green grass
onready var scene = get_tree().get_current_scene()
# Called when the node enters the scene tree for the first time.
func initialize():
	var tf = scene.terrain_file
	print(tf)
	if tf:
		var map_found = false
		for key in tf.keys():
			if key == name:
				map = tf[key]
				map_found = true
		modulate = color
		if map_found:
			for coord in map:
				set_cell(coord[0],coord[1],0)
				update_bitmask_area(Vector2(coord[0],coord[1]))
	else:
		print_debug("Missing terrain...")

func set_point(point):
	set_cell(point.x,point.y,0)
	update_bitmask_area(point)
	map[str(point.x)+","+str(point.y)] = true #save this map to a json
