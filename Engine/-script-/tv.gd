extends Control

func _ready():
	for i in get_children():
		if i is not Panel and i is not AnimationPlayer:
			i.connect("pressed",TV_Press.bind(i))
			i.connect("mouse_entered",func():i.scale=Vector2(1.2,1.2);i.z_index=1;Soft.play_sfx("res://Engine/sfx/jump"))
			i.connect("mouse_exited",func():i.scale=Vector2.ONE;i.z_index=0)

## TV_Buttons
func TV_Press(node):
	var wave = $"wave"
	## Tween Animation
	node.scale = Vector2(1.2,1.2);create_tween().tween_property(node,"scale",Vector2.ONE,0.066)
	## Windows Visible
	#print(node)
	if node.get_child(0) is not AnimatedSprite2D:
		var panel = "res://Engine/-ui-/%s.tscn"%node.get_child(0).text
		owner.add_child(load(panel).instantiate())
		hide()
	else:
		if node.name=="6":wave.play("wave2")
		elif node.name=="13":wave.play("wave1")
	
func area_entered(area):
	var button = area.get_parent()
	area.get_parent().get_node("blank2").show()
	Soft.play_sfx("res://Engine/sfx/jump")
	button.scale = Vector2(1.35,1.35)
	button.z_index = 1
	await Soft.waitime(0.1)
	button.scale = Vector2.ONE

func area_exited(area):
	area.get_parent().get_node("blank2").hide()
	area.get_parent().scale = Vector2.ONE
