extends Control

@onready var r_button = $EX/margin/Scroll/display
@onready var button = [
	[$left/file,$left/display,$left/anmi,$RESET],[r_button.get_node("i_RedAlert 2"),r_button.get_node("i_Yuri's Revenge")],
	get_tree().get_nodes_in_group("pal"),get_tree().get_nodes_in_group("mult_pal"),
	get_tree().get_nodes_in_group("Drag"),$TimeLine/LPad/L.get_children()]
var group = "RedAlert 2/"
var node = null

func _ready():
	######----------------------------------------------------------######
	Soft.BindNode(button[0]+button[1],"pressed",Buttons)
	Soft.BindNode(button[2]+button[3],"pressed",ChangePal)
	Soft.BindNode(button[4],"mouse_entered",func(obj):node=obj;print(obj))
	Soft.BindNode(button[4],"gui_input",Drag)
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
		elif button[3].has(pal):
			for u in button[3]:if u.is_pressed() and u.get_parent().visible:sel_pal += u.name
			sel_pal += ".pal"
		## Read
		var pic_draw = $"../-----".get_child(0).get_node("Image")
		pic_draw.ReadPal("res://ResPack/Palettes/" + group + sel_pal)
		#$"../Panel"
		#pic_draw.ReadPicData()
		$left/Label.text = sel_pal
func Drag(event:InputEvent):
	if node!=null and event.button_mask==1 and event is InputEventMouseMotion:
		if node.name=="tick":
			var pin = $"TimeLine/RPad/n/|||"
			pin.position.x = event.position.x - 9
			if pin.position.x < 0:pin.position.x = 0
			if pin.position.x > button[4][1].size.x - 9:pin.position.x = button[4][1].size.x - 9
			var Pin_Frame = snappedi(snappedf(pin.position.x / 16,0.5),1.0)
			var layer = $"TimeLine/RPad/n/-/times"
			var ticks = $"TimeLine/RPad/n/-/tick".get_children().size() * 5 - 5
			#for i in layer.get_children():
				#if i.get_child(Pin_Frame+1)!=null:
					#i.get_child(Pin_Frame-1).modulate = Color("ffffffff")
					#i.get_child(Pin_Frame).modulate = Color("a0a0a0ff")
					#i.get_child(Pin_Frame+1).modulate = Color("ffffffff")
			## Show Frame
			if $"../-----".get_child_count()!=0:
				var frame =  $"../-----".get_child(0).get_node("Image")
				if Pin_Frame-1!=null:frame.get_child(Pin_Frame-1).hide()
				if Pin_Frame+1!=null:frame.get_child(Pin_Frame+1).hide()
				frame.get_child(Pin_Frame).show()
			#print(Pin_Frame)
		elif node.owner.name=="ClearDream":node.owner.get_parent().position += Vector2i(event.relative)
		elif node.name=="Scroll":node.scroll_vertical -= event.relative.y
		elif node.get_parent().name=="-----":
			var img = node.get_node("Image").get_child(0).texture.get_size()
			var limit = Vector4(148,69,924 - img.x - 4,487 - img.y - 27+83)
			var box = $"../-----".get_child(0).get_child(0)
			box.position += event.relative
			if box.position.x<limit.x:box.position.x=limit.x
			if box.position.y<limit.y:box.position.y=limit.y
			if box.position.x>limit.z:box.position.x=limit.z
			print(img,box)
func File(paths:PackedStringArray):
	######-----------------------ADD  Window---------------------------######
	var window = load("res://Engine/-ui-/-slot-/ra2_image.tscn").instantiate()
	var named = paths[0].split("/")[paths[0].split("/").size()-1]
	window.get_node("Image").Sides.pal = get_tree().get_first_node_in_group("256").get_children()
	window.name = named
	window.name = window.name.replace("_shp","")
	window.position = Vector2(148,66)
	window.imageSize = Vector2(160,120)
	$"../-----/".add_child(window)
	var format = window.get_node("Image")
	format.ReadShp(paths[0])
	window.get_node("title").text = named
	
	Soft.TimeLine_Sliders(1,0,Soft.LoadFrame.Frames)
	Soft.LayerTitle(window.name,paths[0].split(".")[1])
	
