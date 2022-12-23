extends Button


var confirmationPane = load("res://UI/Panes/ConfirmationPane.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BGameSelectButton_button_up():
	var cp = confirmationPane.instance()
	get_parent().get_parent().get_parent().add_child(cp)
	cp.set_game_name(self.text)
	
	

