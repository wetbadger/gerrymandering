extends TileMap


func fill(width, height):
	for x in range(width):
		for y in range(height):
			set_cell(x,y,1)
			
func clear_fog(pos):
	set_cell(pos.x, pos.y, 0, false, false, false)
	update_bitmask_area(pos)
	
func add_fog(pos):
	set_cell(pos.x, pos.y, 1, false, false, false)
	update_bitmask_area(pos)
