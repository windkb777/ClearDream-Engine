extends Node

var ui_color_num : int = 0

func _ready():
	SetGamePath()

func _input(event):
	HotKeys(event)

## Ready
func SetGamePath():
	var BGM = AudioStreamPlayer.new();BGM.stream=AudioStreamMP3.load_from_file("res://Engine/sfx/Chipzel - focus.mp3")
	BGM.name="BackGround-Music";Soft.add_child(BGM)
	## When Press PlayButton Set The GamePath
	var exe = Soft.game_path.split("/")[Soft.game_path.split("/").size()-1]
	Soft.game_path = Soft.game_path.replace("/%s"%exe,"")
	Soft.game_path = Soft.game_path.replace("godot.windows.opt.tools.64.exe/","")

func HotKeys(keys):
	var LPad = $Editer.button[5]
	if keys is InputEventKey:
		var key = ["Shift+Comma","Comma","Space","Period","Shift+Period"]
		if keys.is_pressed():for i in key.size():if keys.as_text() == key[i]:LPad[i].button_pressed = true
		if keys.is_released():for a in key.size():if keys.as_text() == key[a]:LPad[a].button_pressed = false
	#elif keys is InputEventMouseButton:
		#if Soft.Unit!=null and keys.double_click and !Soft.has_node("shp_editer") and keys.button_index==1:
			#var EditMode = load("res://Engine/-ui-/shp_editer.tscn").instantiate();Soft.add_child(EditMode)
			#$Engine/tv.hide();get_child(1).hide()
			#print("edit mode",)

func color_theme():
	const cdr = [
		Color("4f1dadff"),Color("24036bff"),Color("004ab8ff"),Color("c500d2"),Color("0061e1"),
		Color("ad1d1dff"),Color("6b0303ff"),Color("b80000ff"),Color("f06100ff"),Color("e03c00ff"),
		Color("1dad3dff"),Color("036b16ff"),Color("00b834ff"),Color("789f00ff"),Color("064f00ff")]
	const play_color=[Color("f48f00"),Color("f50800ff"),Color("005c03ff"),Color("0056f5"),Color("a10003ff"),Color("006e1bff")]
	var colors = $Engine/UI/Panel/Title.get_theme_stylebox("panel")["texture"]["gradient"]
	var node = [$Engine/UI/Panel/line,$Engine/UI/Button/paint,$Engine/UI/Button/close,$Engine/UI/Button/play,$Engine/UI/Button/debug]
	const sort=[[2,3,4],[7,8,9],[12,13,14]]
	ui_color_num+=1
	if ui_color_num==3:ui_color_num=0
	for i in 2:colors["colors"][i]=cdr[i+(ui_color_num*5)]
	node[0].default_color=cdr[sort[0+ui_color_num][0]]
	node[1].modulate=cdr[sort[0+ui_color_num][1]]
	node[2].modulate=cdr[sort[0+ui_color_num][2]]
	node[3].get_theme_stylebox("normal")["bg_color"]=play_color[ui_color_num]
	node[4].get_theme_stylebox("normal")["bg_color"]=play_color[ui_color_num+3]

	#print(keys.as_text())
	#for i in 9:
		#if keys.as_text() == info[0][i]:
			##if !keys.as_text().contains("V") or !keys.as_text().contains("C") or !keys.as_text().contains("P") or !keys.as_text().contains("F"):
			#if keys.is_pressed():button[3].get_node(info[1][i]).button_pressed = true
			#else:button[3].get_node(info[1][i]).button_pressed = false
			#break
			##else:button[3].get_node(info[1][i]).button_pressed = true
