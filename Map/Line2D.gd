extends Line2D

export var node_path_1 = "../../lvl1"
export var node_path_2 = ".."

var starting_node
var ending_node
var starting_position
var ending_position

var distance
var angle

export (int) var i = 0
export (int) var frames = 300

func _ready():
	set_process(false)

func _draw_line():
	starting_node = get_node(node_path_1)
	ending_node = get_node(node_path_2)
	starting_position = starting_node.get_position()
	ending_position = ending_node.get_position()
	
	var y_2 = ending_position.y
	var y_1 = starting_position.y
	var x_2 = ending_position.x
	var x_1 = starting_position.x
	points[0] = starting_position
	points[1] = starting_position
	distance = sqrt(pow((y_2 - y_1),2) + pow((x_2 - x_1),2))
	angle = atan(distance)
	set_process(true)

func _process(_delta):
	var hypotenuse = distance / (frames - i)
	var x = hypotenuse*sin(angle)
	var y = hypotenuse*cos(angle)
	i+=1
	points[1].x = x
	points[1].y = y
	if i == frames:
		set_process(false)
