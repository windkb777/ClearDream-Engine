extends Control

func _ready():
	Soft.BindNode(get_children(),"pressed",Buttons)

## Button Function
func Buttons(i):
	var tv = owner.get_child(1)
	var Editer = owner.get_child(2)
	var tv_Node = owner.get_child(4)
	Soft.play_sfx("res://Engine/sfx/sel_2")
	match i.name:
		"Editer":tv.hide();Editer.show();if tv_Node!=null:tv_Node.queue_free()
		"Menu":tv.show();Editer.hide();if tv_Node!=null:tv_Node.queue_free()
		"code":
			if $code.is_pressed():print("Code Mode Turn ON!!")
			else:print("Code Mode Turn OFF!")
		"paint":owner.color_theme()
		#"play":Soft.Tool[1].Play_Option()
		#"debug":Soft.Tool[1].Debug_Option()
		"about":
			$"../Engine/tv".hide()
			print("Write About SomeThing")
		"bat":
			if $bat.is_pressed():print("Write OFF")
			else:print("Write ON")
		"window":
			if $window.is_pressed():Soft.Tool[1].Windowed("true ");print("Windowed")
			else:Soft.Tool[1].Windowed("false");print("FullScreen")
		"file":
			if $file.is_pressed():$"../Panel/file".show();$"../Engine".hide()
			else:$"../Panel/file".hide();$"../Engine".show()#$file.menu_visible()
		"close":
			Soft.play_sfx("sel_1")
			await Soft.waitime(0.3)
			get_tree().quit()
