extends Control


func _ready():
	for i in $dies.get_children():i.connect("pressed",button.bind(i))

func button(node):
	$anmi.play(node.name)
