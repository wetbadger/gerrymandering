extends Particles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	restart()
	one_shot = false
	emitting = true
	var t = Timer.new()
	t.set_wait_time(0.4)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	one_shot = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
