extends Control


func _ready():
	owner.pal256 = $Pal_group.get_children()
	$file.connect("pressed",func():$FileDialog.show())
	$display.connect("pressed",func():$anime.play("display"))
	$anmi.connect("pressed",func():$anime.play("anmi"))

func File(path):
	var Name = path.split("/")[path.split("/").size()-1]
	WindowsImage(Name,path)
	TimeLine_Sliders(Soft.file,Name)
	#LayerTitle(Name,path.split(".")[1])
	#print(Soft.LoadFrame.Frames)

func WindowsImage(Name,path):
	######-----------------------ADD  Window---------------------------######
	var window = load("res://Engine/-ui-/-slot-/ra2_image.tscn").instantiate()
	window.name = Name
	window.name = window.name.replace("_shp","")
	window.position = Vector2(148,66)
	window.imageSize = Vector2(160,120)
	$"../-----".add_child(window)
	window.get_node("title").text = Name
	window.get_node("Image").ReadShp(path)
	Soft.file.windows.append(window)
	owner.sel_file = window

func TimeLine_Sliders(data,namd):
	#print(data.layer,data.offset)
	### Bucket Block Set
	var Bucket = load("res://Engine/-ui-/-slot-/frame.tscn").instantiate()
	var blocks = $"../TimeLine/RPad".Sliders
	blocks.add_child(Bucket,true)
	## Set Slider
	Bucket.position = Vector2(data.layer[1]*16+2,data.layer[0]*18+10+data.layer[0]*4-1);
	Bucket.size = Vector2(data.frames*16-2,20)
	Soft.file.windows.append(Bucket)

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
