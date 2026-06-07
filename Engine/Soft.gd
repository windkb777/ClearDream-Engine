extends Node

var game_path = OS.get_executable_path()
var Tool = [Ra2md.new(),Bat.new()]
var SmallUIs = {}
var Unit = {}
#var WindowUI = null

var LoadFrame = {Frames=0}

## Windows Contral
func DragWindows(event,obj=get_parent()):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		obj.position += Vector2i(event.relative)
func NewWindow(tscn):
	var scene = load(tscn).instantiate()
	get_parent().add_child(scene)
	scene.show()
	#subbox = scene
#func IFV_Ware(select):
	#select

## Global Function
func 概率():
	var result
	var def = ["默认启动","启默动方"]
	const ars = "Ares方式启动"
	var type = ["A","B"].pick_random()
	#A
	if   type == "A":result = randi_range(0,99)
	#B
	elif type == "B":
		result = randf_range(randi_range(randi()%12,randi()%100),randf_range(randi()%12,randi()%100))
		result = str(result).substr(6,randi_range(1,2))
	match result:
		0:$OptionButton.set_item_text(0,def[0])
		99:$OptionButton.set_item_text(0,def[1]);$OptionButton.set_item_text(1,ars)
	return result
func play_sfx(path):
	var sfx = AudioStreamPlayer.new()
	sfx.connect("finished",sfx.queue_free)
	add_child(sfx)
	sfx.volume_db = randf_range(-12,0)
	#sfx.stream = load("res://Engine/sfx/"+path+)
	sfx.stream = load(path + ".wav")
	sfx.play()
func waitime(time):
	await get_tree().create_timer(time).timeout
## Simple Func
func BindNode(nodes,signals,funcs):
	if nodes is Array:
		for i in nodes:
			if signals!="gui_input":i.connect(signals,funcs.bind(i))
			if signals=="gui_input":i.connect(signals,funcs)
	elif nodes is Button:nodes.connect(signals,funcs)
	
		
func NodesVisible(node:Array,flag:Array):
	for i in 5:
		if node[i] is not Array:
			if flag[i]==true:node[i].show()
			else:node[i].hide()
		else:
			for a in node[i].size():
				if flag[i]==true:node[i][a].show()
				else:node[i][a].hide()
## Styles
func LayerTitle(Name,type):
	var layer = load("res://Engine/-ui-/-slot-/layer_1.tscn").instantiate()
	var layer_group = get_parent().get_child(1).get_node("%LPad")
	layer_group.add_child(layer)
	## Del Temp Layer
	var layer_temp = get_parent().get_child(1).get_node("%LPad").get_child(1)
	if layer_temp.get_child(1).text=="file":layer_temp.queue_free()
	## 
	layer.get_node("file").text = Name
	layer.get_node("type").text = type
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
	Bucket.size = Vector2(frames*18-14,20);
	get_parent().get_child(1).get_node("%block").add_child(Bucket,true)
## Panel Func
func ImageExport(num):
	var Cameo = [get_parent().get_child(1).get_node("Viewer/info/Cameo/icon"),get_parent().get_child(1).get_node("Viewer/info/AltCameo/icon")]
	var path = "res://Plugin/" + Unit["Cameo"]
	var type = ["_Art.ini","_Rules.ini","icon.png","uico.png","_SpriteSheels.png",".gif"]
	var pic = get_viewport().get_texture().get_image()
	match num:
		0:pic.get_region(Rect2i(Cameo[0].global_position,Vector2i(60,48))).save_png(path+type[2])
		1:pic.get_region(Rect2i(Cameo[1].global_position,Vector2i(60,48))).save_png(path+type[3])
