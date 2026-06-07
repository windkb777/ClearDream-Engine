extends Control

@onready var button = [$side.get_children(),$country.get_children(),$"tech-tree".get_children(),$"tech-tree/GDI/spec",$"tech-tree/NOD/spec"]


func _ready():
	for i in button[0]:i.connect("pressed",buttons.bind(i))

func buttons(node):
	for i in button[0].size():
		if button[0][i].is_pressed():
			button[0][i].modulate = Color.WHITE
			button[1][i].show()
			button[2][i].show()
		else:
			button[0][i].modulate = Color.DIM_GRAY
			button[1][i].hide()
			button[2][i].hide()
	#print(node)
