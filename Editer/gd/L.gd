extends Control

func _ready():
	owner.pal256 = $Pal_group.get_children()
	$file.connect("pressed",func():$FileDialog.show())
	for i in [$display,$anmi]:i.connect("pressed",EX_Panel_Return.bind(i))

func File(path):
	var Name = path.split("/")[path.split("/").size()-1]
	WindowsImage(Name,path)
	TimeLine_Sliders(Soft.file)
	#LayerTitle(Name,path.split(".")[1])
	#print(Soft.LoadFrame.Frames)

func WindowsImage(Name,path):
	######-----------------------ADD  Window---------------------------######
	var window = load("res://Editer/slot/ra2_image.tscn").instantiate()
	var window_img = window.get_node("|/Image")
	window.name = Name
	window.name = window.name.replace("_shp","")
	window.get_node("title").text = Name
	window_img.ReadShp(path)
	window_img.size = Soft.file.size
	window.position = Vector2(148,66)
	$"../../-----".add_child(window)
	Soft.file.windows.append(window)
	owner.sel_file = window

func TimeLine_Sliders(data):
	### Bucket Block Set
	var Bucket = load("res://Editer/slot/frame.tscn").instantiate()
	var blocks = $"../TimeLine/RPad".Sliders
	blocks.add_child(Bucket,true)
	## Set Slider
	Bucket.position = Vector2(data.layer[1]*16+2,data.layer[0]*18+10+data.layer[0]*4-1);
	Bucket.size = Vector2(data.frames*16-2,20)
	Soft.file.windows.append(Bucket)
	#print(data.frames)

func LayerTitle(Name,type):
	var layer = load("res://Engine/-ui-/-slot-/layer_1.tscn").instantiate()
	var layer_group = owner.get_node("%LPad")
	layer_group.add_child(layer)
	## Del Temp Layer
	var layer_temp = layer_group.get_child(1)
	if layer_temp.get_child(1).text=="file":layer_temp.queue_free()
	## 
	layer.get_node("file").text = Name
	layer.get_node("type").text = type
	Soft.file.windows.append(layer)
	#print(Name,type)

func EX_Panel_Return(node):
	$anime.play(node.name)
	await Soft.waitime(3.5)
	for i in [$display,$anmi]:i.button_pressed=false
	$anime.play_backwards()
