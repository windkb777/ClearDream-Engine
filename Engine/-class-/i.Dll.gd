class_name Dll
extends Node

var Unit = {}
var ui_color_num : int = 0

## Change UI to 3 Base Color 
func color_theme():
	const cdr = [
		Color("4f1dadff"),Color("24036bff"),Color("004ab8ff"),Color("c500d2"),Color("0061e1"),
		Color("ad1d1dff"),Color("6b0303ff"),Color("b80000ff"),Color("f06100ff"),Color("e03c00ff"),
		Color("1dad3dff"),Color("036b16ff"),Color("00b834ff"),Color("789f00ff"),Color("064f00ff")]
	const play_color=[Color("f48f00"),Color("f50800ff"),Color("005c03ff"),Color("0056f5"),Color("a10003ff"),Color("006e1bff")]
	var colors = $Engine/UI/Title.get_theme_stylebox("panel")["texture"]["gradient"]
	var node = [$Engine/UI/line,$Engine/Button/paint,$Engine/Button/close,$Engine/Button/play,$Engine/Button/debug]
	const sort=[[2,3,4],[7,8,9],[12,13,14]]
	ui_color_num+=1
	if ui_color_num==3:ui_color_num=0
	for i in 2:colors["colors"][i]=cdr[i+(ui_color_num*5)]
	node[0].default_color=cdr[sort[0+ui_color_num][0]]
	node[1].modulate=cdr[sort[0+ui_color_num][1]]
	node[2].modulate=cdr[sort[0+ui_color_num][2]]
	node[3].get_theme_stylebox("normal")["bg_color"]=play_color[ui_color_num]
	node[4].get_theme_stylebox("normal")["bg_color"]=play_color[ui_color_num+3]

## Set SoftWare Path
func SoftWarePath():
	var BGM = AudioStreamPlayer.new();BGM.stream=AudioStreamMP3.load_from_file("res://Engine/sfx/Chipzel - focus.mp3")
	BGM.name="BackGround-Music";Soft.add_child(BGM)
	## When Press PlayButton Set The GamePath
	var exe = Soft.game_path.split("/")[Soft.game_path.split("/").size()-1]
	Soft.game_path = Soft.game_path.replace("/%s"%exe,"")
	Soft.game_path = Soft.game_path.replace("godot.windows.opt.tools.64.exe/","")

## Set SoftWare HotKeys
func HotKeys(keys):
	var LPad = $Editer.button[5]
	if keys is InputEventKey:
		var key = ["Shift+Comma","Comma","Space","Period","Shift+Period"]
		if keys.is_pressed():for i in key.size():if keys.as_text() == key[i]:LPad[i].button_pressed = true
		if keys.is_released():for a in key.size():if keys.as_text() == key[a]:LPad[a].button_pressed = false

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

## Export
#func ImageExport(num):
	#var Cameo = [get_parent().get_child(1).get_node("Viewer/info/Cameo/icon"),get_parent().get_child(1).get_node("Viewer/info/AltCameo/icon")]
	#var path = "res://Plugin/" + Unit["Cameo"]
	#var type = ["_Art.ini","_Rules.ini","icon.png","uico.png","_SpriteSheels.png",".gif"]
	#var pic = get_viewport().get_texture().get_image()
	#match num:
		#0:pic.get_region(Rect2i(Cameo[0].global_position,Vector2i(60,48))).save_png(path+type[2])
		#1:pic.get_region(Rect2i(Cameo[1].global_position,Vector2i(60,48))).save_png(path+type[3])
