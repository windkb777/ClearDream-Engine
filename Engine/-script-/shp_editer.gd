extends Control

@onready var r_button = $EX/margin/Scroll/display
@onready var editer = get_parent().get_node("Editer")
@onready var button = [
	[$left/file,$left/display,$left/anmi,$RESET],[r_button.get_node("i_RedAlert 2"),r_button.get_node("i_Yuri's Revenge")],
	get_tree().get_nodes_in_group("pal"),get_tree().get_nodes_in_group("mult_pal"),
	get_tree().get_nodes_in_group("Drag"),$TimeLine/LPad/L.get_children()]
var group = "RedAlert 2/"
var node = null

var Layer = {L=null,S=null,P=null}

var Sides = {pal=null,res=[],colorPos={}}


func _ready():
	######----------------------------------------------------------######
	Soft.BindNode(button[0]+button[1],"pressed",Buttons)
	Soft.BindNode(button[2]+button[3],"pressed",ChangePal)
	Soft.BindNode(button[4],"mouse_entered",func(obj):node=obj)
	Soft.BindNode(button[4],"gui_input",Drag)
	#for i in editer.get_node("%block").get_children():
		#i.connect("focus_entered",func():slider=i)
	######----------------------------------------------------------######


func Buttons(nodes):
	var anmi = $anime
	match nodes.name:
		"i_RedAlert 2":ChangePal(button[1][0]);group = "RedAlert 2/"
		"i_Yuri's Revenge":ChangePal(button[1][1]);group = "Yuri's Revenge/"
		"file":$FileDialog.show()
	if nodes.name=="RESET":for i in button[0]:if i.is_pressed() and i.name!="RESET":anmi.play_backwards(i.name);i.button_pressed=false
	if nodes.name == "display" or nodes.name == "anmi":anmi.play(nodes.name)

func ChangePal(pal):
	if pal.name.contains("i_"):
		for i in ["RedAlert 2_pal","Yuri's Revenge_pal"]:
			r_button.get_node(i).hide()
			r_button.get_node(pal.name.replace("i_","")+"_pal").show()
	else:
		var sel_pal = ""
		if button[2].has(pal):sel_pal = pal.name + ".pal"
		if button[3].has(pal):
			for u in button[3]:if u.is_pressed() and u.get_parent().visible:sel_pal += u.name
			sel_pal += ".pal"
		## Read
		ReadPal("res://ResPack/Palettes/" + group + sel_pal)
		$left/Label.text = sel_pal
		$"../-----".get_child(0).get_node("Image").get_child(0).queue_redraw()
func Drag(event:InputEvent):
	if event.button_mask==1 and event is InputEventMouseMotion:
		if node.name=="tick":
			var pin = $"TimeLine/RPad/n/|||"
			pin.position.x = event.position.x - 9
			if pin.position.x < 0:pin.position.x = 0
			if pin.position.x > button[4][2].size.x - 9:pin.position.x = button[4][2].size.x - 9
			var Pin_Frame = snappedi(snappedf(pin.position.x / 16,0.5),1.0)
			var layer = $"TimeLine/RPad/n/-/times"
			var ticks = $"TimeLine/RPad/n/-/tick".get_children().size() * 5 - 5
			## Show Frame
			if $"../-----".get_child_count()!=0:
				var frame =  $"../-----".get_child(0).get_node("Image")
				var max = frame.get_child_count()
				if Pin_Frame-1 < -1:frame.get_child(0).hide()
				elif Pin_Frame+1 > max:frame.get_child(max-1).hide()
				else:for i in frame.get_children().size():
					frame.get_child(Pin_Frame).show()
					if i!=0:frame.get_child(i).hide()
					#print(i)

		elif node.owner.name=="ClearDream":node.owner.get_parent().position += Vector2i(event.relative)
		elif node.name=="Scroll":node.scroll_vertical -= event.relative.y

			#print(img,box)
func File(paths:PackedStringArray):
	var Name = paths[0].split("/")[paths[0].split("/").size()-1]
	Sides.pal = $left/Pal_group.get_children()
	WindowsImage(Name,paths[0])
	TimeLine_Sliders(1,0,Soft.LoadFrame.Frames)
	LayerTitle(Name,paths[0].split(".")[1])
	print(Soft.LoadFrame.Frames)

func WindowsImage(Name,path):
	######-----------------------ADD  Window---------------------------######
	var window = load("res://Engine/-ui-/-slot-/ra2_image.tscn").instantiate()
	window.get_node("Image").Sides.pal = get_tree().get_first_node_in_group("256").get_children()
	window.name = Name
	window.name = window.name.replace("_shp","")
	window.position = Vector2(148,66)
	window.imageSize = Vector2(160,120)
	$"../-----".add_child(window)
	window.z_index = 2
	var format = window.get_node("Image")
	window.get_node("title").text = Name
	format.ReadShp(path)
	Layer.P = window
func LayerTitle(Name,type):
	var layer = load("res://Engine/-ui-/-slot-/layer_1.tscn").instantiate()
	var layer_group = editer.get_node("%LPad")
	layer_group.add_child(layer)
	## Del Temp Layer
	var layer_temp = layer_group.get_child(1)
	if layer_temp.get_child(1).text=="file":layer_temp.queue_free()
	## 
	layer.get_node("file").text = Name
	layer.get_node("type").text = type
	Layer.L = layer
	#print(Name,type)
func TimeLine_Sliders(layer:int,offset:int,frames:int):
	## Bucket Block Set
	var PosBlock = [16,22]
	var Bucket = Button.new();Bucket.name = "Block_1";
	var nColor = StyleBoxFlat.new();nColor.bg_color = Color("af74ff");nColor.set_corner_radius_all(3)
	#Bucket.font_size = 13.0;Bucket.font_color = Color("661aff")
	Bucket.add_theme_stylebox_override("normal",nColor)
	## Set Slider
	Bucket.position = Vector2(2+PosBlock[0]*offset,9+PosBlock[1]*layer);
	Bucket.size = Vector2(frames*14,20);
	editer.get_node("%block").add_child(Bucket,true)
	Bucket.connect("gui_input",detail)
	Layer.S = Bucket
func detail(event:InputEvent):
	if event is InputEventMouseButton:
		if event.button_mask==2:
			var menu = $SliderMenu
			menu.position=get_local_mouse_position()
			menu.show()
			#print(slider)

func ReadPal(pal_file):
	##加载读取文件
	var loader = FileAccess.get_file_as_bytes(pal_file)
	##读取颜色,768/3=256,63x4=252
	for i in range(0,loader.size(),3):
		var pal_array = []
		pal_array.append(loader.slice(i,i+3))
		var colored = Color.from_rgba8(pal_array[0][0]*4,pal_array[0][1]*4,pal_array[0][2]*4)
		Sides.pal[i/3].color = colored
func is_color_similar(c1:Color,c2:Color,threshold:float=0.1)->bool:
	# 计算 RGB 空间距离
	var dr = c1.r - c2.r
	var dg = c1.g - c2.g
	var db = c1.b - c2.b
	var dist = sqrt(dr*dr + dg*dg + db*db)
	return dist < threshold
func SliderMenu(index):
	match index:
		0:button[0][0].pressed.emit()
		1:for i in Layer.values():
			i.queue_free()
		#2:
		#3:
