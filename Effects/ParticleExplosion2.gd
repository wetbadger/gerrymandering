extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var t = null
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	$Sound.play()

	var rand = rng.randi()%6
	var explosion = get_node("Explosion")
	match rand:
		0:
			explosion.modulate = Color(1, 0, 0)
		1:
			explosion.modulate = Color(0, 1, 0)
		2:
			explosion.modulate = Color(0, 0, 1)
		3:
			explosion.modulate = Color(1, 1, 0)
		4:
			explosion.modulate = Color(0, 1, 1)
		5:
			explosion.modulate = Color(1, 0, 1)
		_:
			explosion.modulate = Color(1, 1, 1)
	
#	set_process(true) # Replace with function body.

	t = Timer.new()
	t.set_wait_time(5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	queue_free()
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	var speed_x = 0
#	var speed_y = 1
#	var motion = Vector2(speed_x, speed_y) * 100
#	set_position(get_position() + motion * delta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
