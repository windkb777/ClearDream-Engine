extends Control

func _ready():
	for i in get_child(0).get_children():i.connect("pressed",button.bind(i))

func button(node):
	var tv = $"../../tv"
	var Editer = $"../../Editer"
	match node.name:
		"Editer":tv.hide();Editer.show()#;if tv_Node!=null:tv_Node.queue_free()
		"Menu":tv.show();Editer.hide()#;if tv_Node!=null:tv_Node.queue_free()
		#"paint":owner.color_theme()
		"close":Soft.play_sfx("sel_1");await Soft.waitime(0.3);get_tree().quit()
