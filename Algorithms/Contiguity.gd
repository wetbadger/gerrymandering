extends Node

var shape = {}

func _ready():
	pass

func addPoint(point):
	shape[str(point)] = {}
	shape[str(point)]["visited"] = false
	shape[str(point)]["point"] = point
	
func removePoint(point):
	shape.erase(str(point))
	
func isContiguous(starting_point):
	# Initialize a stack for the depth-first search
	var stack = []
	# Push the starting point onto the stack
	var sp = starting_point
	stack.push_back(sp)
	# Initialize a variable to keep track of the number of points visited
	var visited = 0
	# While the stack is not empty
	while (!stack.empty()):

		# Pop the top element from the stack
		var current = stack.back()
		stack.pop_back()

		# If the current point has not been visited yet
		if !shape[str(current)]["visited"]:

			# Mark the point as visited
			shape[str(current)]["visited"] = true
			# Increment the number of points visited
			visited+=1
			# Add all contiguous points to the stack
			if shape.has(str(Vector2(current.x + 1, current.y))):
				stack.push_back(Vector2(current.x + 1, current.y))
			if shape.has(str(Vector2(current.x - 1, current.y))):
				stack.push_back(Vector2(current.x - 1, current.y))
			if shape.has(str(Vector2(current.x, current.y + 1))):
				stack.push_back(Vector2(current.x, current.y + 1))
			if shape.has(str(Vector2(current.x, current.y - 1))):
				stack.push_back(Vector2(current.x, current.y - 1))

	# Set all values in the map to unvisited.
	for value in shape:
		shape[value]["visited"] = false

	# Return true if all points have been visited, false otherwise
	return visited == shape.size()
