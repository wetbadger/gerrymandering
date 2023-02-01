extends Node2D

var t = null
var rng = RandomNumberGenerator.new()

onready var scene = get_tree().get_current_scene()

func _ready():
	$Explosion.emitting = false
	$Smoke.emitting = false
	$Explosion.one_shot = true
	$Smoke.one_shot = true
	var rand
	rng.randomize()
	rand = rng.randi()%3


	match rand:
		0:
			$Sound1.play()
		1:
			$Sound2.play()
		2:
			$Sound3.play()


	$Explosion.emitting = true
	$Smoke.emitting = true



	rand = rng.randi()%7
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

	t = Timer.new()
	t.set_wait_time(5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	
	
	
	
	queue_free()
