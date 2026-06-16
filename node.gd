extends Node

func _ready():
	tick(61)



func tick(num):
	for i in num:
		var t = Label.new()
		#var nums = str(0 + i * 5)
		var nums = str(0 + i)
		t.name = nums
		t.text = nums
		t.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER
		$tick.add_child(t)
	## 
		style("b",$Z1)
		for a in 4:style("a",$Z1)

func value_changed(value):
	$tick.add_theme_constant_override("separation",value)



func style(node,parent):
	var button = Button.new();button.name="0";button.button_mask=MOUSE_BUTTON_MASK_RIGHT;button.custom_minimum_size=Vector2(18,24)
	var stylebox = StyleBoxFlat.new();stylebox.set_border_width_all(2);stylebox.border_color=Color("373737")
	button.add_theme_stylebox_override("normal",stylebox)
	match node:
		"a":stylebox.bg_color=Color("505050")
		"b":stylebox.bg_color=Color("464646")
	parent.add_child(button,true)
