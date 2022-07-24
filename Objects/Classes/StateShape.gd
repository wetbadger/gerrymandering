#
#
#	Requires: Area2D->Sprite,CollisionPolygon2D
#
#

extends Node2D

class_name StateShape

func measure_width_and_height():
	#TODO: for non perfectly square shapes measure the tile height and width at the longest bones on the state polygon
	var shape_rect = get_node("ReferenceRect").get_rect()
	var corner = get_global_position() + Vector2(shape_rect.position.x, shape_rect.position.y)
	return [corner, shape_rect.size]
