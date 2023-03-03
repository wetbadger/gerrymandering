extends RigidBody2D

onready var scene = get_parent()

func _ready():
	pass


func _physics_process(_delta):
	var collision = get_colliding_bodies()
	if collision:
		if "Seat" in collision[0].name:
			scene.shrink()
