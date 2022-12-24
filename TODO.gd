extends Node


"""

TODO:
	load saved settings
	
	CPP module for:
		runtime contiguity detection
		when click is draged from district but not connected, draw a connecting line
		autofill
		computer drawn district for multiplayer
	
	
	house algorithm
		fill
		spiral
		circle
	house dstribution
		random (fix)
		city vs country (like-houses together, different densities of people)
		clustered (random but like-houses together)
		[done] houses placed by user
		
	Fog of War
	User-Created Shapes
	
	[done] touch screen hold-to-delete function
	[done] touchscreen drag and zoom (deselect district button)
	[done] turn off run time contiguity enforcement
	[done] turn off contiguity
	
	settings:
		music
		sfx
		orientation
	
	fireworks: one for each house that won only in viewport
	ability to explore / screenshot after victory screen
	menu to quit to main menu in game
	adjust screen layout for devices

	draw houses better (fix copyright infringement)
	
	infinite map
	
	different types of houses
		Apartments with more people on a square
		Farms, with more land
		Mansions, with more money
		trees, rocks, and other assets
		maps with rivers and multiple collision squares, (can districts cross the river?)
		
	brush size increase with zoom
	
	Tooltip facts and explanations of settings:
		contiguous:
			Each district cannot be split into two shapes. They must be connected. 
			fact: 20 states do not require that congressional districts be contiguous.

	multiplayer:
		any number of human or computer players
		computer can draw a district (see c++)
		
		Stage 1. Draw power or People cards
			Power cards represent the ability to draw a district.
			People cards represent voters.
			
		Stage 2. Players take turns placing voters in a
			predetermined map
			
		Stage 3. Players take turns drawing districts.
			The most disadvantaged player goes first.
			(It will be math-heavy to calculate atvantages XD)
		
	Campaigns (Tutorial, Storymode, etc.):
		A game folder points to another game folder 
			and eventually a completion screen.
		Develop a teir system for more optimal solutions
			(bronze silver gold) 
		
	make puzzles:
		10 puzzles
		50 puzzles
		250 puzzles
		1000 puzzles
		2000 puzzles
		3000 puzzles
		Thats probably enough puzzles

NOTE: remember to uncomment out the mouseclick event in the main scene

"""
