extends Node


"""

What was I doing:
	...

TODO:
	
	Cursor:
		Drawing:
			Over filled square
			Over empty square
		Moving:
			Grabbing Hand
		Menus:
			Pointing Hand
		
	
	Ticker for minimum sized districts. 
		[done] Ticks down when the min is reached.
		[done] Ticks up when max is reached or less than min
		Symbol for district button when min is reached
	Overall progress meter
	
	[done] load saved settings
	
	CPP module for:
		[done] runtime contiguity detection
		when click is draged from district but not connected, draw a connecting line
		autofill
		computer drawn district for multiplayer
			easy: randomly picks squares and checks if valid.
			hard: uses a strategy (rip from codewars)
			very hard: uses a strategy and predicts player move
	
	
	house algorithm
		[done] fill
		[done] spiral
		circle
	house dstribution
		random (fix)
		city vs country (like-houses together, different densities of people)
		clustered (random but like-houses together)
		[done] houses placed by user
		
	User placed mode:
		[done] ability to edit an existing matrix
		ability to change number of houses available
		
	[done] Fog of War
	
	[done] touch screen hold-to-delete function
	[done] touchscreen drag and zoom (deselect district button)
	[done] turn off run time contiguity enforcement
	[done] turn off contiguity
	
	settings:
		music
		sfx
		orientation
	
	[done] fireworks: one for each house that won only in viewport
	ability to explore / screenshot after victory screen
	[done] menu to quit to main menu in game
	adjust screen layout for devices

	draw original houses (fix copyright infringement)
	
	infinite map
	
	different types of houses
		[done] Apartments with more people on a square
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
		
		Stage 1. Draw Power or People or Money cards
			Power cards represent the ability to draw a district.
			People cards represent voters.
			Money cards give spender a chance to flip a vote or two 
				(discourages tie strategies and narrow victories)
			
			Each player starts with 5 voters, no districts, and $100
			
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
		[done] Create a map screen
		Tutorial:
			[done] Sally the Salamander teaches you how to play.
			
		Legislative vs Commitee:
			Legislative mode: player controls all districts
				purple shape
			Commitee mode: Multiplayer or player v computer
				orange shape
		
	make puzzles:
		10 puzzles
		50 puzzles
		250 puzzles
		1000 puzzles
		2000 puzzles
		3000 puzzles
		Thats probably enough puzzles

NOTE: remember to uncomment out the mouseclick event in the main scene

BUGS:
	1. [FIXED] User Place mode holding down to erase "claimed land" will make 
		house disapear without tallying 
	2. [FIXED] Shape is not always matched to hardcoded levels on different screen sizes
	3. [FIXED] Hardcoded levels not showing percentages on victory
	4. End Game is bugged for non-tutoria maps

"""
