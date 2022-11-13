extends Control

func _ready():
	if not OS.request_permissions():
		print ("An unexpected error occured when trying to get OS permissions.")
