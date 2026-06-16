extends Panel

func _gui_input(event):
	if event.button_mask==1 and event is InputEventMouseMotion:
		owner.get_parent().position += Vector2i(event.relative)
