extends Node

var map_name

var default_settings = {
		"name": "My State",
		"contiguous" : true,
		"diagonals" : false,
		"n_districts" : 5,
		"max_size" : 5,
		"min_size" : 5,
		"width" : 5,
		"parties" : {
			"Red Party" : {"voters": 10, "asset": "res://pics/sprites/red_house.png", "color": "red"},
			"Blue Party" : {"voters": 15, "asset": "res://pics/sprites/blue_house.png", "color": "blue"}
		},
		"empty_tiles" : false,
		"empty_tiles_fillable" : false,
		"auto_size": false,
		"size_based_on" : "largest_factor",
		"even_sizes": true,
		"colors" : {
			"blue" : [0.1,0.6,0.7],
			"red" : [0.8,0.1,0.1],
			"orange" : [0.8,0.4,0.1],
			"green" : [0.2,0.8,0.1],
			"purple" : [0.5,0.2,0.8],
			"yellow" : [0.8,0.8,0.0],
			"brown" : [0.2,0.2,0.3],
			"white" : [1,1,1],
			"gray" : [0.5,0.5,0.5],
			"teal" : [0.1,0.8,0.8],
			"pink" : [0.8,0.1,0.7]
		},
		"none_selected_start_erasing" : false,
		"debug" : true,
		"layout":["random"]
}
