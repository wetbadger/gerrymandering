extends Panel

func _ready():
	var label = get_node("Name")

	if label.rect_size.x < 320:
		fit_font(50, 5, 8)
	elif label.rect_size.x >= 320 and label.rect_size.x < 700:
		fit_font(40, 10, 8)
	elif label.rect_size.x >= 700 and label.rect_size.x < 1000:
		fit_font(23, 20, 8)
	elif label.rect_size.x >= 1000:
		fit_font(16, 30, 8)

func fit_font(size, margTop, margLeft):
	var label = get_node("Name")
		# Get the default font directly
	var default_font = $Name.theme.default_font

	if default_font != null:
		# Create a new theme
		var new_theme = Theme.new()
		# Create a new DynamicFont with the desired size
		var modified_font = DynamicFont.new()
		modified_font.font_data = default_font.font_data
		modified_font.size = size  # Replace 20 with your desired font size
		new_theme.default_font = modified_font
		# Create a new Label with the modified theme
		var new_label = Label.new()
		new_label.rect_min_size = Vector2(100, 30)  # Set the size you want
		new_label.theme = new_theme
		#new_label.theme.default_font = modified_font
		new_label.text = label.text
		new_label.margin_top = margTop
		new_label.margin_left = margLeft
		# Replace the existing Label with the new one
		replace_child(label, new_label)
	else:
		print("Default font not found in the theme.")
		
func replace_child(node, new_label):
	node.queue_free()
	add_child(new_label)
