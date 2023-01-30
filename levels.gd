extends Node

var settings = {

	"lvl1" : {
		
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
		
		"name": "lvl2",
		"pointer": null,
		"parties": {
			"You": {
				"voters": 9,
				"asset": 0,
				"color": "red"
			},
			"Opponent": {
				"voters": 17,
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
	}
}


var matrices = {
	"lvl1" : {
		"anchor" : {
			"type" : "Anchor",
			"coords" : "(71, 29)"
		},
		"(58, 30)": {
			"type": "House",
			"coords": "(58, 30)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(58, 29)": {
			"type": "House",
			"coords": "(58, 29)",
			"visited": false,
			"allegiance": "You"
		},
		"(57, 30)": {
			"type": "House",
			"coords": "(57, 30)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(59, 30)": {
			"type": "House",
			"coords": "(59, 30)",
			"visited": false,
			"allegiance": "You"
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
			"allegiance": "You"
		},
		"(57, 32)": {
			"type": "House",
			"coords": "(57, 32)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(58, 32)": {
			"type": "House",
			"coords": "(58, 32)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(59, 32)": {
			"type": "House",
			"coords": "(59, 32)",
			"visited": false,
			"allegiance": "You"
		},
		"(60, 32)": {
			"type": "House",
			"coords": "(60, 32)",
			"visited": false,
			"allegiance": "You"
		},
		"(59, 31)": {
			"type": "House",
			"coords": "(59, 31)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(60, 31)": {
			"type": "House",
			"coords": "(60, 31)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(60, 30)": {
			"type": "House",
			"coords": "(60, 30)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(60, 29)": {
			"type": "House",
			"coords": "(60, 29)",
			"visited": false,
			"allegiance": "Opponent"
		},
		"(59, 29)": {
			"type": "House",
			"coords": "(59, 29)",
			"visited": false,
			"allegiance": "Opponent"
		}
	},
	"lvl2" : {
		"anchor" : {
			"type" : "Anchor",
			"coords" : "(64, 30)"
		},
		"(57, 30)": {
			"type": "Gap",
			"coords": "(57, 30)",
			"visited": false
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
			"type": "Gap",
			"coords": "(56, 31)",
			"visited": false
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
	}
}
