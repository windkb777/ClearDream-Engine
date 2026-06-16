extends ScrollContainer

@onready var Pin = $"-/Pin"
@onready var TimeLine = $"-/TimeLine"
@onready var Sliders = $"-/Sliders"

var Pin_Frame : int

func _ready():
	TimeLine.get_node("tick").connect("gui_input",PinSlide)
	for i in TimeLine.get_node("times").get_children():for a in i.get_children():a.connect("gui_input",detail.bind(a))
	

func PinSlide(event:InputEvent):
	if event.button_mask==1 and event is InputEventMouseMotion:
		var Limit = [0,TimeLine.get_node("tick").size.x-16]
		Pin.position.x = event.position.x - 9
		## Limit
		if Pin.position.x < Limit[0]:Pin.position.x = Limit[0]
		if Pin.position.x > Limit[1]:Pin.position.x = Limit[1]
		## Nums
		ShowFrames()

func ShowFrames():
	Pin_Frame = snappedi(snappedf(Pin.position.x / 16,0.5),1.0)
	if owner.sel_file!=null:
		var frame =  Soft.file.windows[0].imgs
		var _max = frame.get_child_count()
		var SelFrame = (Soft.file.windows[1].position.x-2)/16
		## Limit Head & End Frames Visible
		if Pin_Frame-1 < -1:frame.get_child(0).hide()
		elif Pin_Frame+1 > _max:frame.get_child(_max-1).hide()
		## Show Hide Current Frame
		else:
			for i in _max:if frame.get_child(i).visible==true:frame.get_child(i).hide()
			frame.get_child(Pin_Frame).show()
			#print(Pin_Frame-5)
				#elif Pin_Frame==SelFrame-i:
					#print(Pin_Frame+_max)
					#frame.get_child(SelFrame).show()

func detail(event:InputEvent,node2):
	if event is InputEventMouseButton:
		if event.button_mask==2:
			var menu = $SliderMenu
			menu.show();menu.position=get_global_mouse_position() + Vector2(815,410)
			Soft.file.layer = [node2.get_parent().get_index()+1,node2.get_index()]
			print(Soft.file.layer)
func detail_items(index):
	match index:
		0:$"../../left".get_node("file").pressed.emit()
		1:print(Soft.file)
		2:pass
		3:pass

#func TimeSet(maxFrame):
	#var frame = $"-/TimeLine/times"

	
	#for i in 4:
		#frame.get_node("z1").add_child(b,true)
	#for i in frame.get_children():
		#for c in 4:i.add_child(b,true)
		#i.add_child(a,true)
		#
		#i.add_child(a,true)
		#i.add_child(a,true)
		#i.add_child(b,true)
	#add_sibling(a)
	#add_sibling(b)
	#print(a,b)
