extends Control

@onready var node = [$SideColor,$hue,$color_1,$color_2,$input/d_hsv,$input/d_rgb,$input/r_hsv,$input/r_rgb,$pal.get_children()]
#@onready var Sides = {pal=node[0].get_children(),res=[],colorPos={}}
var num = 0
var sel = null

func _ready():
	color()
	node[1].connect("color_changed",Text)
	$add.connect("pressed",colorslot)
	$input/name.connect("text_changed",func(new:String):sel.text = new)
	for i in node[8]:
		i.connect("pressed",func():num=i.get_index();node[1].color = i.get_theme_stylebox("normal").bg_color;node[2].color=node[1].color)
	for i in $names.get_children():
		i.connect("mouse_entered",func():sel=i)
		i.connect("mouse_exited",func():sel=null)
		i.connect("gui_input",zone)

func zone(event:InputEvent):
	if event.is_pressed() and event.button_mask==1:
		$sel.position = sel.position - Vector2(5,11.5)
		$input/name.text = sel.text
		$color_2.color = $colors.get_child(sel.get_index()).color
		Text($color_2.color)

func Text(color):
	node[2].color = color;node[3].color = node[2].color
	## Color Text
	node[6].text = str(int(color.h*255))+","+str(int(color.s*255))+","+str(int(color.v*255))
	node[7].text = str(int(color.r*255))+","+str(int(color.g*255))+","+str(int(color.b*255))
	node[4].text = str(int(color.h*359))+","+str(int(color.s*100))+","+str(int(color.v*100))
	node[5].text = str(snappedf(color.r,0.001))+","+str(snappedf(color.g,0.001))+","+str(snappedf(color.b,0.001))

## 设置颜色小方格
func colorslot():
	var style = StyleBoxFlat.new();style.set_bg_color(node[2].color);style.set_corner_radius_all(4)
	if num<19:num+=1
	else:num=0
	node[8][num].add_theme_stylebox_override("normal",style)

########################################################################
func color():
	var cmd = [
		Soft.md.Title("Color Schemes"),
		colors(),
		hardcode()
	]
	for i in cmd:print(i)

func colors():
	var output = "[Colors]\n"
	for i in 16:
		var named = $names.get_children()
		var colod = $colors.get_children()
		output+=named[i].text+$input/r_hsv.text+"="
		output+=str(int(colod[i].color.h*255))+","+str(int(colod[i].color.s*255))+","+str(int(colod[i].color.v*255))+"\n"
	return output
func hardcode():
	var hd = "
	[ColorAdd]
	;Name	RGB values	bit vales				color#
	None=0,0,0			;00000,000000,00000		0
	StrongRed=31,0,0	;11111,000000,00000		1
	StrongGreen=0,63,0	;00000,111111,00000		2
	StrongBlue=0,0,31	;00000,000000,11111		3
	HighRed=24,0,0		;11000,000000,00000		4
	HighGreen=0,56,0	;00000,111000,00000		5
	HighBlue=0,0,24		;00000,000000,11000		6
	BrightWhite=31,63,31;11111,111111,11111		7
	LowWhite=7,7,7		;00111,000111,00111		8
	HighWhite=24,56,24	;11000,111000,11000		9
	MidWhite=14,28,14	;01110,011100,01110		10
	Purple=15,0,15		;01111,000000,01111		11
	HighYellow=24,56,0 ;11000,111000,00000     12
	TopYellow=16,32,0;10000,100000,00000		13".dedent()
	return hd
