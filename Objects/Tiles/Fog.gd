extends TileMap


func fill(width, height):
	for x in range(width):
		for y in range(height):
			set_cell(x,y,1)
			
func clear_fog(position):
	set_cell(position.x, position.y, 0, false, false, false)
	update_bitmask_area(position)
