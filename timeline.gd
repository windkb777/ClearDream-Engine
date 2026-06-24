extends Node



func _ready():
	tick(61)

func gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index==4 or event.button_index==5:
			#for i in $ColorRect/tick.get_children():
				
			print(event.position)

func value_changed(value):
	pass
	#for i in 61:
		#var label = $ColorRect/tick.get_child(i)
		#var frame = $Z1.get_child(i)
		#frame.position.x = i * value
		#label.position.x = frame.position.x
		#if value>100:print("SSS")

func tick(num):
	for i in num / 5:
		text(i*5,num)
		style("b")
		for a in 4:
			text(a+(i*5)+1,num,$ColorRect/tick_detail)
			style("a")
	text(num-1,num)
	style("b")

func style(node,parent=$Z1):
	var button = Button.new();button.name="0";button.button_mask=MOUSE_BUTTON_MASK_RIGHT;button.custom_minimum_size=Vector2(18,24)
	var stylebox = StyleBoxFlat.new();stylebox.set_border_width_all(2);stylebox.border_color=Color("373737")
	button.add_theme_stylebox_override("normal",stylebox)
	match node:
		"a":stylebox.bg_color=Color("505050")
		"b":stylebox.bg_color=Color("464646")
	parent.add_child(button,true)

func text(i,num,parent=$ColorRect/tick,v=true):
	var t = Label.new()
	t.add_theme_font_size_override("font_size",12)
	t.custom_minimum_size = Vector2(18,0)
	t.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER
	t.name = str(i)
	t.text = str(i)
	if v:t.position.x = i * 17
	else:t.position.x = i / 5 * 17
	parent.add_child(t)
	
