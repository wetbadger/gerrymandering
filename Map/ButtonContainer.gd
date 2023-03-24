extends Node2D

onready var fill1 = get_node("HBox/Fill1")
onready var fill2 = get_node("HBox/Fill2")
onready var btn1 = get_node("HBox/Start2")
onready var btn2 = get_node("HBox/GotoMenu")
onready var viewport_rect = get_viewport_rect()

func _ready():
	var width1 = btn1.rect_size.x
	var width2 = btn2.rect_size.x
	var fill1_size = viewport_rect.size.x/2 - width1/2
	fill1.rect_min_size.x = fill1_size
	var fill2_size = viewport_rect.size.x/2 - width2 - width1/2 - 10
	fill2.rect_min_size.x = fill2_size

