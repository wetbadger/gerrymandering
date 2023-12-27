extends TileMap


var map = {}

export var color = Color(.1,.5,.2,1) #a default green grass
onready var scene = get_tree().get_current_scene()
# Called when the node enters the scene tree for the first time.
func initialize():
	var tf = scene.terrain_file
	if not tf:
		tf = Globals.current_terrain
	var map_data #data is stored in file a little bit different
	if tf:
		var map_found = false
		for key in tf.keys():
			if key == name:
				map_data = tf[key]
				map_found = true
				if map_data.has("color"):
					color = str2var("Color("+map_data["color"]+")")
					
		if map_found:
			for coord in map_data["points"]:
				map[str(coord[0])+","+str(coord[1])] = true
				set_cell(coord[0],coord[1],0)
				update_bitmask_area(Vector2(coord[0],coord[1]))
	else:
		print_debug("Missing terrain...")
		
	modulate = color

func set_point(point):
	set_cell(point.x,point.y,0)
	update_bitmask_area(point)
	map[str(point.x)+","+str(point.y)] = true #save this map to a json

func remove_point(point):
	set_cell(point.x,point.y,-1)
	update_bitmask_area(point)
	map[str(point.x)+","+str(point.y)] = false #save this map to a json
