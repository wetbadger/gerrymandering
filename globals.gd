extends Node

var map_name

var default_settings = {
		"name": "My State",
		"contiguous" : true,
		"diagonals" : false,

		"parties" : {
			"Red Party" : {"voters": 10, "asset": "Red House", "color": "red"},
			"Blue Party" : {"voters": 15, "asset": "Blue House", "color": "blue"}
		},
		"districts" : {
			"A" : {
				"max_size" : 5,
				"min_size" : 5,
				"color" : "blue"
				},
			"B" : {
				"max_size" : 5,
				"min_size" : 5,
				"color" : "red"
				},
			"C" : {
				"max_size" : 5,
				"min_size" : 5,
				"color" : "orange"
				},
			"D" : {
				"max_size" : 5,
				"min_size" : 5,
				"color" : "green"
				},
			"E" : {
				"max_size" : 5,
				"min_size" : 5,
				"color" : "purple"
				}
		},
		"gaps": true,
		"colors" : {
			"blue" : [0.0,0.0,0.9],
			"red" : [0.8,0.1,0.1],
			"orange" : [0.8,0.4,0.1],
			"green" : [0.2,0.8,0.1],
			"purple" : [0.5,0.2,0.8],
			"yellow" : [0.8,0.8,0.0],
			"brown" : [0.3,0.2,0.0],
			"white" : [1,1,1],
			"gray" : [0.5,0.5,0.5],
			"teal" : [0.1,0.8,0.8],
			"pink" : [0.8,0.1,0.7],
			"black" : [0,0,0]
		},
		"assets" : {
			"Red House" : 0,
			"Blue House" : 1,
			"White House" : 2,
			"Purple House" : 3,
			"Green House" : 4,
			"Yellow House" : 5,
			"Adobe House" : 6,
			"Tent" : 7
		},
		"none_selected_start_erasing" : false,
		"debug" : true,
		"layout":["random"]
}

func word2color(word):
	if word:
		return arr2color(default_settings["colors"][word])

func arr2color(arr):
	return Color(arr[0],arr[1],arr[2])
