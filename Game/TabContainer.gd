extends TabContainer

onready var house_buttons = get_node("Houses/HouseButtons")
onready var scenery_buttons = get_node("Scenery/SceneryButtons")
onready var scene = get_tree().get_current_scene()

var save_selected = null

func _on_TabContainer_tab_changed(tab):
	if tab == 1:
		scene.draw_mode = scene.DRAW_MODES.TERRAIN
		if save_selected:
			save_selected.pressed = true
			if save_selected.name == "ClearTerrain":
				scene.draw_mode = scene.DRAW_MODES.CLEAR
		#unselect house buttons
		for btn in house_buttons.get_children():
			if btn.pressed:
				save_selected = btn
				btn.pressed = false
		#select terrain button
		#set terrain layer
	if tab == 0:
		if save_selected:
			save_selected.pressed = true
		scene.draw_mode = scene.DRAW_MODES.PLACE
		#unselect terrain button
		for btn in scenery_buttons.get_children():
			if btn.pressed:
				save_selected = btn
				btn.pressed = false
		#select house button
