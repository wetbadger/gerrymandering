extends Button


onready var scene = get_tree().get_current_scene()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ClearTerrain_button_up():
	scene.draw_mode = scene.DRAW_MODES.CLEAR
	var buttons = self.get_parent().get_children()
	for b in buttons:
		if b != self:
			b.pressed = false
	self.pressed = true
