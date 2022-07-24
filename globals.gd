extends Node

var map_name

var default_settings = {
		"name": "My State",

		"parties" : {
			"Reds" : {"voters": 10, "asset": "Red House", "color": "red"},
			"Blues" : {"voters": 15, "asset": "Blue House", "color": "blue"}
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
		"advanced" : {
			"gaps": true,
			"contiguous" : true,
			"diagonals" : false,
			"debug" : false,
			"layout": ["random"],
			"algorithm" : ["spiral", "fill"]
		},
		"shape": "Garryland",
		"colors" : {
			"blue" : [0.25,0.25,1],
			"red" : [0.8,0.1,0.1],
			"white" : [1,1,1],
			"purple" : [0.5,0.2,0.8],
			"green" : [0.2,0.8,0.1],
			"yellow" : [0.8,0.8,0.0],
			"orange" : [0.8,0.4,0.1],
			"brown" : [0.3,0.2,0.0],
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
		}
}

var default_names = {
	"prefixes" : [
		"blip",
		"bloop",
		"blob",
		"glip",
		"gloop",
		"glob",
		"bob",
		"lol",
		"lib",
		"con",
		"gil",
		"wang",
		"flip",
		"floop",
		"flop",
		"flim",
		"flam",
		"fash",
		"bim",
		"boop",
		"bop",
		"cat",
		"dog",
		"zoop",
		"zip",
		"nerp",
		"erm",
		"nom",
		"gif",
		"flimb",
		"bebop",
		"beat",
		"mod",
		"nic",
		"epub",
		"bubl",
		"blubl",
		"blub",
		"nub",
		"nubl",
		"fluffl",
		"fluff",
		"puff",
		"puffl",
		"huff",
		"huffl",
		"is"
	],
	"suffixes" : [
		"icans",
		"ocrats",
		"ists",
		"atives",
		"erals",
		"itarians",
		"alists",
		"ians",
		"inati"
	]
}

func word2color(word):
	if word:
		return arr2color(default_settings["colors"][word])

func arr2color(arr):
	return Color(arr[0],arr[1],arr[2])
