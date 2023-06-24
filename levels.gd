extends Node

var settings = {

	"lvl1" : {
		"tutorial": 1,
		"camera" : {
			"zoom":0.2,
			"position": [770,580]
		},
		"name": "lvl1",
		"pointer": ["lvl2"],
		"parties": {
			"You": {
				"voters": 6,
				"asset": 0,
				"color": "red"
			},
			"Opponent": {
				"voters": 9,
				"asset": 1,
				"color": "blue"
			}
		},
		"districts": {
			"A": {
				"max": 5,
				"min": 5,
				"color": "blue",
				"party": [
					"You",
					"Opponent"
				]
			},
			"B": {
				"max": 5,
				"min": 5,
				"color": "red",
				"party": [
					"Opponent",
					"You"
				]
			},
			"C": {
				"max": 5,
				"min": 5,
				"color": "orange",
				"party": [
					"You",
					"Opponent"
				]
			}
		},
		"advanced": {
			"District Rules": {
				"contiguous": true,
				"runtime contiguity enforcement": false,
				"diagonals": false,
				"show grid": false,
				"multiplayer": false
			},
			"House Placement": {
				"gaps": true,
				"randomize positions": false,
				"layout": [
					"random",
					"user placed"
					
				],
				"algorithm": [
					"hardcoded",
					"load from file",
					"spiral",
					"fill"
				]
			},
			"Other": {
				"debug": false
			}
		},
		"shape": "TutoriaMinor",
		"colors": {
			"blue": [
				0.25,
				0.25,
				1
			],
			"red": [
				0.8,
				0.1,
				0.1
			],
			"orange": [
				0.8,
				0.4,
				0.1
			],
			"purple": [
				0.5,
				0.2,
				0.8
			],
			"yellow": [
				0.8,
				0.8,
				0
			],
			"brown": [
				0.3,
				0.2,
				0
			],
			"green": [
				0.2,
				0.8,
				0.1
			],
			"white": [
				1,
				1,
				1
			],
			"gray": [
				0.5,
				0.5,
				0.5
			],
			"teal": [
				0.1,
				0.8,
				0.8
			],
			"pink": [
				0.8,
				0.1,
				0.7
			],
			"black": [
				0,
				0,
				0
			]
		},
		"assets": {
			"Red House": 0,
			"Blue House": 1,
			"White House": 2,
			"Purple House": 3,
			"Green House": 4,
			"Yellow House": 5,
			"Adobe House": 6,
			"Tent": 7,
			"Happy Blue": 8,
			"Happy Red": 9
		}
	}, 
	
	"lvl2" : {
		"camera" : {
			"zoom":0.2,
			"position": [1050,550]
		},
		"name": "lvl2",
		"pointer": ["lvl3"],
		"parties": {
			"You": {
				"voters": 10,
				"asset": 0,
				"color": "red"
			},
			"Opponent": {
				"voters": 18,
				"asset": 1,
				"color": "blue"
			}
		},
		"districts": {
			"A": {
				"max": 6,
				"min": 5,
				"color": "blue",
				"party": [
					"You",
					"Opponent"
				]
			},
			"B": {
				"max": 6,
				"min": 5,
				"color": "red",
				"party": [
					"Opponent",
					"You"
				]
			},
			"C": {
				"max": 6,
				"min": 5,
				"color": "orange",
				"party": [
					"You",
					"Opponent"
				]
			},
			"D": {
				"max": 6,
				"min": 5,
				"color": "purple",
				"party": [
					"Opponent",
					"You"
				]
			},
			"E": {
				"max": 6,
				"min": 5,
				"color": "yellow",
				"party": [
					"You",
					"Opponent"
				]
			}
		},
		"advanced": {
			"District Rules": {
				"contiguous": true,
				"runtime contiguity enforcement": false,
				"diagonals": false,
				"show grid": false,
				"multiplayer": false
			},
			"House Placement": {
				"gaps": true,
				"randomize positions": false,
				"layout": [
					"random",
					"user placed"
				],
				"algorithm": [
					"hardcoded",
					"load from file",
					"spiral",
					"fill"
				]
			},
			"Other": {
				"debug": false
			}
		},
		"shape": "TutoriaMinor",
		"colors": {
			"blue": [
				0.25,
				0.25,
				1
			],
			"red": [
				0.8,
				0.1,
				0.1
			],
			"orange": [
				0.8,
				0.4,
				0.1
			],
			"purple": [
				0.5,
				0.2,
				0.8
			],
			"yellow": [
				0.8,
				0.8,
				0
			],
			"brown": [
				0.3,
				0.2,
				0
			],
			"green": [
				0.2,
				0.8,
				0.1
			],
			"white": [
				1,
				1,
				1
			],
			"gray": [
				0.5,
				0.5,
				0.5
			],
			"teal": [
				0.1,
				0.8,
				0.8
			],
			"pink": [
				0.8,
				0.1,
				0.7
			],
			"black": [
				0,
				0,
				0
			]
		},
		"assets": {
			"Red House": 0,
			"Blue House": 1,
			"White House": 2,
			"Purple House": 3,
			"Green House": 4,
			"Yellow House": 5,
			"Adobe House": 6,
			"Tent": 7,
			"Happy Blue": 8,
			"Happy Red": 9
		}
	},
	"lvl3": {
		"camera" : {
			"zoom":0.2,
			"position": [1100,550]
		},
		"name": "lvl3",
		"pointer": null,
		"parties": {
			"You": {
				"voters": 24,
				"asset": 0,
				"color": "red"
			},
			"Opponent": {
				"voters": 43,
				"asset": 1,
				"color": "blue"
			},
			"Fizzlicans": {
				"voters": 7,
				"asset": 2,
				"color": "orange"
			}
		},
		"districts": {
			"A": {
				"max": 15,
				"min": 14,
				"color": "blue",
				"party": [
					"You",
					"Opponent",
					"Fizzlicans"
				]
			},
			"B": {
				"max": 15,
				"min": 14,
				"color": "red",
				"party": [
					"Opponent",
					"You",
					"Fizzlicans"
				]
			},
			"C": {
				"max": 15,
				"min": 14,
				"color": "orange",
				"party": [
					"Fizzlicans",
					"You",
					"Opponent"
				]
			},
			"D": {
				"max": 15,
				"min": 14,
				"color": "purple",
				"party": [
					"You",
					"Opponent",
					"Fizzlicans"
				]
			},
			"E": {
				"max": 15,
				"min": 14,
				"color": "yellow",
				"party": [
					"Opponent",
					"You",
					"Fizzlicans"
				]
			}
		},
		"advanced": {
			"District Rules": {
				"contiguous": true,
				"runtime contiguity enforcement": false,
				"diagonals": false,
				"show grid": false,
				"multiplayer": false
			},
			"House Placement": {
				"gaps": true,
				"randomize positions": false,
				"layout": [
					"random",
					"user placed"
				],
				"algorithm": [
					"hardcoded",
					"fill",
					"spiral"
				]
			},
			"Other": {
				"debug": false
			}
		},
		"shape": "TutoriaMinor",
		"colors": {
			"blue": [
				0.25,
				0.25,
				1
			],
			"red": [
				0.8,
				0.1,
				0.1
			],
			"orange": [
				0.8,
				0.4,
				0.1
			],
			"purple": [
				0.5,
				0.2,
				0.8
			],
			"yellow": [
				0.8,
				0.8,
				0
			],
			"brown": [
				0.3,
				0.2,
				0
			],
			"green": [
				0.2,
				0.8,
				0.1
			],
			"white": [
				1,
				1,
				1
			],
			"gray": [
				0.5,
				0.5,
				0.5
			],
			"teal": [
				0.1,
				0.8,
				0.8
			],
			"pink": [
				0.8,
				0.1,
				0.7
			],
			"black": [
				0,
				0,
				0
			]
		},
		"assets": {
			"Red House": 0,
			"Blue House": 1,
			"Orange House": 2,
			"Purple House": 3,
			"Yellow House": 4,
			"Green House": 5,
			"Weird House": 6
		}
	}
}


var matrices = {
	"lvl1" : {
		"(42, 30)": {
			"type": "House",
			"coords": "(42, 30)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(43, 30)": {
			"type": "House",
			"coords": "(43, 30)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(44, 30)": {
			"type": "House",
			"coords": "(44, 30)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(41, 31)": {
			"type": "House",
			"coords": "(41, 31)",
			"visited": false,
			"allegiance": "You"
		},
		"(42, 31)": {
			"type": "House",
			"coords": "(42, 31)",
			"visited": false,
			"allegiance": "You"
		},
		"(43, 31)": {
			"type": "House",
			"coords": "(43, 31)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(44, 31)": {
			"type": "House",
			"coords": "(44, 31)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(41, 32)": {
			"type": "House",
			"coords": "(41, 32)",
			"visited": false,
			"allegiance": "You"
		},
		"(42, 32)": {
			"type": "House",
			"coords": "(42, 32)",
			"visited": false,
			"allegiance": "You"
		},
		"(43, 32)": {
			"type": "House",
			"coords": "(43, 32)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(44, 32)": {
			"type": "House",
			"coords": "(44, 32)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(41, 33)": {
			"type": "House",
			"coords": "(41, 33)",
			"visited": false,
			"allegiance": "You"
		},
		"(42, 33)": {
			"type": "House",
			"coords": "(42, 33)",
			"visited": false,
			"allegiance": "You"
		},
		"(43, 33)": {
			"type": "House",
			"coords": "(43, 33)",
			"visited": false,
			"allegiance": "You"
		},
		"(44, 33)": {
			"type": "House",
			"coords": "(44, 33)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"anchor": {
			"type": "Anchor",
			"coords": "(55, 30)"
		}
	},
	"lvl2" : {
		"anchor" : {
			"type" : "Anchor",
			"coords" : "(64, 30)"
		},
		"(57, 30)": {
			"type": "House",
			"coords": "(57, 30)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(58, 30)": {
			"type": "House",
			"coords": "(58, 30)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(58, 31)": {
			"type": "House",
			"coords": "(58, 31)",
			"visited": false,
			"allegiance": "You"
		},
		"(57, 31)": {
			"type": "House",
			"coords": "(57, 31)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(56, 31)": {
			"type": "House",
			"coords": "(56, 31)",
			"visited": false,
			"allegiance": "You"
		},
		"(56, 30)": {
			"type": "House",
			"coords": "(56, 30)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(56, 29)": {
			"type": "House",
			"coords": "(56, 29)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(57, 29)": {
			"type": "Gap",
			"coords": "(57, 29)",
			"visited": false
		},
		"(58, 29)": {
			"type": "Gap",
			"coords": "(58, 29)",
			"visited": false
		},
		"(59, 29)": {
			"type": "Gap",
			"coords": "(59, 29)",
			"visited": false
		},
		"(59, 30)": {
			"type": "Gap",
			"coords": "(59, 30)",
			"visited": false
		},
		"(59, 31)": {
			"type": "Gap",
			"coords": "(59, 31)",
			"visited": false
		},
		"(59, 32)": {
			"type": "Gap",
			"coords": "(59, 32)",
			"visited": false
		},
		"(58, 32)": {
			"type": "House",
			"coords": "(58, 32)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(57, 32)": {
			"type": "Gap",
			"coords": "(57, 32)",
			"visited": false
		},
		"(56, 32)": {
			"type": "Gap",
			"coords": "(56, 32)",
			"visited": false
		},
		"(55, 32)": {
			"type": "Gap",
			"coords": "(55, 32)",
			"visited": false
		},
		"(55, 31)": {
			"type": "Gap",
			"coords": "(55, 31)",
			"visited": false
		},
		"(55, 30)": {
			"type": "House",
			"coords": "(55, 30)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(55, 29)": {
			"type": "House",
			"coords": "(55, 29)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(55, 28)": {
			"type": "Gap",
			"coords": "(55, 28)",
			"visited": false
		},
		"(56, 28)": {
			"type": "House",
			"coords": "(56, 28)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(57, 28)": {
			"type": "House",
			"coords": "(57, 28)",
			"visited": false,
			"allegiance": "You"
		},
		"(58, 28)": {
			"type": "House",
			"coords": "(58, 28)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(59, 28)": {
			"type": "Gap",
			"coords": "(59, 28)",
			"visited": false
		},
		"(60, 28)": {
			"type": "House",
			"coords": "(60, 28)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(60, 29)": {
			"type": "House",
			"coords": "(60, 29)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(60, 30)": {
			"type": "House",
			"coords": "(60, 30)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(60, 31)": {
			"type": "Gap",
			"coords": "(60, 31)",
			"visited": false
		},
		"(60, 32)": {
			"type": "House",
			"coords": "(60, 32)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(60, 33)": {
			"type": "Gap",
			"coords": "(60, 33)",
			"visited": false
		},
		"(59, 33)": {
			"type": "Gap",
			"coords": "(59, 33)",
			"visited": false
		},
		"(58, 33)": {
			"type": "Gap",
			"coords": "(58, 33)",
			"visited": false
		},
		"(57, 33)": {
			"type": "House",
			"coords": "(57, 33)",
			"visited": false,
			"allegiance": "You"
		},
		"(56, 33)": {
			"type": "Gap",
			"coords": "(56, 33)",
			"visited": false
		},
		"(55, 33)": {
			"type": "Gap",
			"coords": "(55, 33)",
			"visited": false
		},
		"(54, 33)": {
			"type": "House",
			"coords": "(54, 33)",
			"visited": false,
			"allegiance": "You"
		},
		"(54, 32)": {
			"type": "House",
			"coords": "(54, 32)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(54, 31)": {
			"type": "House",
			"coords": "(54, 31)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(54, 30)": {
			"type": "Gap",
			"coords": "(54, 30)",
			"visited": false
		},
		"(54, 29)": {
			"type": "Gap",
			"coords": "(54, 29)",
			"visited": false
		},
		"(54, 28)": {
			"type": "Gap",
			"coords": "(54, 28)",
			"visited": false
		},
		"(54, 27)": {
			"type": "Gap",
			"coords": "(54, 27)",
			"visited": false
		},
		"(55, 27)": {
			"type": "House",
			"coords": "(55, 27)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(56, 27)": {
			"type": "House",
			"coords": "(56, 27)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(57, 27)": {
			"type": "House",
			"coords": "(57, 27)",
			"visited": false,
			"allegiance": "You"
		},
		"(58, 27)": {
			"type": "House",
			"coords": "(58, 27)",
			"visited": false,
			"allegiance": "You"
		},
		"(59, 27)": {
			"type": "Gap",
			"coords": "(59, 27)",
			"visited": false
		},
		"(60, 27)": {
			"type": "Gap",
			"coords": "(60, 27)",
			"visited": false
		},
		"(61, 27)": {
			"type": "House",
			"coords": "(61, 27)",
			"visited": false,
			"allegiance": "You"
		},
		"(61, 28)": {
			"type": "House",
			"coords": "(61, 28)",
			"visited": false,
			"allegiance": "You"
		},
		"(61, 29)": {
			"type": "House",
			"coords": "(61, 29)",
			"visited": false,
			"allegiance": "You"
		},
		"(61, 33)": {
			"type": "Gap",
			"coords": "(61, 33)",
			"visited": false
		}
	},
	"lvl3": {
		"(53, 27)": {
			"type": "Gap",
			"coords": "(53, 27)",
			"visited": false
		},
		"(53, 28)": {
			"type": "House",
			"coords": "(53, 28)",
			"visited": false,
			"allegiance": "You"
		},
		"(53, 29)": {
			"type": "House",
			"coords": "(53, 29)",
			"visited": false,
			"allegiance": "You"
		},
		"(53, 30)": {
			"type": "House",
			"coords": "(53, 30)",
			"visited": false,
			"allegiance": "You"
		},
		"(53, 31)": {
			"type": "Gap",
			"coords": "(53, 31)",
			"visited": false
		},
		"(53, 32)": {
			"type": "Gap",
			"coords": "(53, 32)",
			"visited": false
		},
		"(53, 33)": {
			"type": "Gap",
			"coords": "(53, 33)",
			"visited": false
		},
		"(53, 34)": {
			"type": "Gap",
			"coords": "(53, 34)",
			"visited": false
		},
		"(54, 34)": {
			"type": "Gap",
			"coords": "(54, 34)",
			"visited": false
		},
		"(55, 34)": {
			"type": "Gap",
			"coords": "(55, 34)",
			"visited": false
		},
		"(56, 34)": {
			"type": "Gap",
			"coords": "(56, 34)",
			"visited": false
		},
		"(57, 34)": {
			"type": "House",
			"coords": "(57, 34)",
			"visited": false,
			"allegiance": "You"
		},
		"(58, 34)": {
			"type": "Gap",
			"coords": "(58, 34)",
			"visited": false
		},
		"(59, 34)": {
			"type": "House",
			"coords": "(59, 34)",
			"visited": false,
			"allegiance": "You"
		},
		"(60, 34)": {
			"type": "Gap",
			"coords": "(60, 34)",
			"visited": false
		},
		"(61, 34)": {
			"type": "Gap",
			"coords": "(61, 34)",
			"visited": false
		},
		"(62, 34)": {
			"type": "Gap",
			"coords": "(62, 34)",
			"visited": false
		},
		"(63, 34)": {
			"type": "Gap",
			"coords": "(63, 34)",
			"visited": false
		},
		"(64, 34)": {
			"type": "Gap",
			"coords": "(64, 34)",
			"visited": false
		},
		"(54, 27)": {
			"type": "Gap",
			"coords": "(54, 27)",
			"visited": false
		},
		"(55, 27)": {
			"type": "House",
			"coords": "(55, 27)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(56, 27)": {
			"type": "House",
			"coords": "(56, 27)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(57, 27)": {
			"type": "House",
			"coords": "(57, 27)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(57, 28)": {
			"type": "House",
			"coords": "(57, 28)",
			"visited": false,
			"allegiance": "You"
		},
		"(58, 28)": {
			"type": "House",
			"coords": "(58, 28)",
			"visited": false,
			"allegiance": "You"
		},
		"(59, 28)": {
			"type": "House",
			"coords": "(59, 28)",
			"visited": false,
			"allegiance": "You"
		},
		"(57, 29)": {
			"type": "House",
			"coords": "(57, 29)",
			"visited": false,
			"allegiance": "Fizzlicans"
		},
		"(58, 29)": {
			"type": "House",
			"coords": "(58, 29)",
			"visited": false,
			"allegiance": "Fizzlicans"
		},
		"(59, 29)": {
			"type": "House",
			"coords": "(59, 29)",
			"visited": false,
			"allegiance": "Fizzlicans"
		},
		"(60, 28)": {
			"type": "House",
			"coords": "(60, 28)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(61, 28)": {
			"type": "House",
			"coords": "(61, 28)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(62, 28)": {
			"type": "House",
			"coords": "(62, 28)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(60, 29)": {
			"type": "House",
			"coords": "(60, 29)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(62, 29)": {
			"type": "House",
			"coords": "(62, 29)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(61, 30)": {
			"type": "House",
			"coords": "(61, 30)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(62, 30)": {
			"type": "House",
			"coords": "(62, 30)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(61, 31)": {
			"type": "House",
			"coords": "(61, 31)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(61, 32)": {
			"type": "House",
			"coords": "(61, 32)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(62, 32)": {
			"type": "House",
			"coords": "(62, 32)",
			"visited": false,
			"allegiance": "Opponent",
			"voters": 4
		},
		"(62, 31)": {
			"type": "House",
			"coords": "(62, 31)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(63, 29)": {
			"type": "House",
			"coords": "(63, 29)",
			"visited": false,
			"allegiance": "You"
		},
		"(63, 30)": {
			"type": "House",
			"coords": "(63, 30)",
			"visited": false,
			"allegiance": "You"
		},
		"(63, 31)": {
			"type": "House",
			"coords": "(63, 31)",
			"visited": false,
			"allegiance": "You"
		},
		"(64, 29)": {
			"type": "House",
			"coords": "(64, 29)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(64, 30)": {
			"type": "House",
			"coords": "(64, 30)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(64, 31)": {
			"type": "House",
			"coords": "(64, 31)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(65, 30)": {
			"type": "House",
			"coords": "(65, 30)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(65, 31)": {
			"type": "House",
			"coords": "(65, 31)",
			"visited": false,
			"allegiance": "Opponent",
			"voters": 6
		},
		"(65, 29)": {
			"type": "House",
			"coords": "(65, 29)",
			"visited": false,
			"allegiance": "You",
			"voters": 2
		},
		"(65, 28)": {
			"type": "House",
			"coords": "(65, 28)",
			"visited": false,
			"allegiance": "You"
		},
		"(66, 28)": {
			"type": "House",
			"coords": "(66, 28)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(66, 29)": {
			"type": "Gap",
			"coords": "(66, 29)",
			"visited": false
		},
		"(66, 27)": {
			"type": "Gap",
			"coords": "(66, 27)",
			"visited": false
		},
		"(65, 27)": {
			"type": "Gap",
			"coords": "(65, 27)",
			"visited": false
		},
		"(64, 27)": {
			"type": "Gap",
			"coords": "(64, 27)",
			"visited": false
		},
		"(63, 27)": {
			"type": "Gap",
			"coords": "(63, 27)",
			"visited": false
		},
		"(62, 27)": {
			"type": "Gap",
			"coords": "(62, 27)",
			"visited": false
		},
		"(61, 27)": {
			"type": "Gap",
			"coords": "(61, 27)",
			"visited": false
		},
		"(60, 27)": {
			"type": "Gap",
			"coords": "(60, 27)",
			"visited": false
		},
		"(59, 27)": {
			"type": "Gap",
			"coords": "(59, 27)",
			"visited": false
		},
		"(58, 27)": {
			"type": "Gap",
			"coords": "(58, 27)",
			"visited": false
		},
		"(64, 28)": {
			"type": "Gap",
			"coords": "(64, 28)",
			"visited": false
		},
		"(63, 28)": {
			"type": "Gap",
			"coords": "(63, 28)",
			"visited": false
		},
		"(63, 32)": {
			"type": "Gap",
			"coords": "(63, 32)",
			"visited": false
		},
		"(64, 32)": {
			"type": "House",
			"coords": "(64, 32)",
			"visited": false,
			"allegiance": "Opponent",
			"voters": 5
		},
		"(64, 33)": {
			"type": "House",
			"coords": "(64, 33)",
			"visited": false,
			"allegiance": "Opponent",
			"voters": 3
		},
		"(63, 33)": {
			"type": "House",
			"coords": "(63, 33)",
			"visited": false,
			"allegiance": "You"
		},
		"(62, 33)": {
			"type": "House",
			"coords": "(62, 33)",
			"visited": false,
			"allegiance": "You"
		},
		"(61, 33)": {
			"type": "Gap",
			"coords": "(61, 33)",
			"visited": false
		},
		"(60, 33)": {
			"type": "House",
			"coords": "(60, 33)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(59, 33)": {
			"type": "House",
			"coords": "(59, 33)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(59, 32)": {
			"type": "House",
			"coords": "(59, 32)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(59, 31)": {
			"type": "House",
			"coords": "(59, 31)",
			"visited": false,
			"allegiance": "You"
		},
		"(57, 31)": {
			"type": "House",
			"coords": "(57, 31)",
			"visited": false,
			"allegiance": "You"
		},
		"(58, 31)": {
			"type": "Gap",
			"coords": "(58, 31)",
			"visited": false
		},
		"(58, 32)": {
			"type": "Gap",
			"coords": "(58, 32)",
			"visited": false
		},
		"(58, 33)": {
			"type": "Gap",
			"coords": "(58, 33)",
			"visited": false
		},
		"(57, 32)": {
			"type": "House",
			"coords": "(57, 32)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(57, 33)": {
			"type": "House",
			"coords": "(57, 33)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(56, 33)": {
			"type": "House",
			"coords": "(56, 33)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(56, 32)": {
			"type": "House",
			"coords": "(56, 32)",
			"visited": false,
			"allegiance": "You",
			"voters": 2
		},
		"(56, 31)": {
			"type": "House",
			"coords": "(56, 31)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(56, 30)": {
			"type": "House",
			"coords": "(56, 30)",
			"visited": false,
			"allegiance": "You",
			"voters": 4
		},
		"(57, 30)": {
			"type": "House",
			"coords": "(57, 30)",
			"visited": false,
			"allegiance": "Fizzlicans"
		},
		"(58, 30)": {
			"type": "House",
			"coords": "(58, 30)",
			"visited": false,
			"allegiance": "Fizzlicans"
		},
		"(59, 30)": {
			"type": "House",
			"coords": "(59, 30)",
			"visited": false,
			"allegiance": "Fizzlicans"
		},
		"(60, 30)": {
			"type": "Gap",
			"coords": "(60, 30)",
			"visited": false
		},
		"(60, 31)": {
			"type": "House",
			"coords": "(60, 31)",
			"visited": false,
			"allegiance": "Fizzlicans"
		},
		"(60, 32)": {
			"type": "Gap",
			"coords": "(60, 32)",
			"visited": false
		},
		"(61, 29)": {
			"type": "Gap",
			"coords": "(61, 29)",
			"visited": false
		},
		"anchor": {
			"type": "Anchor",
			"coords": "(55, 30)"
		}
	}
}
