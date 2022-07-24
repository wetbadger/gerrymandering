extends ColorRect

enum {DARK, LIGHT}

var mode = DARK

func _ready():
	set_process(false)

func darken():
	set_process(true)
	mode = DARK
	
func lighten():
	set_process(true)
	mode = LIGHT
	
func _process(_delta):
	match mode:
		DARK:
			color.a += 0.01
		LIGHT:
			color.a -= 0.01
	if color.a >= 0.8 or color.a <= 0:
		set_process(false)
