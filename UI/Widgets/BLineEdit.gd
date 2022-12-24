extends LineEdit

var parent

func _ready():
	parent = get_parent().get_parent().get_parent().get_parent()

func _on_BLineEdit_text_changed(new_text):
	#TODO: update district pane text changed?
	if parent.name == "parties":
		parent.district_pane.alternate_ownerships()


func _on_BLineEdit_focus_exited():
	#TODO: update district pane when focus exited?
	if parent.name == "parties":
		parent.district_pane.alternate_ownerships()
