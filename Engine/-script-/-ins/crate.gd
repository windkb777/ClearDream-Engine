extends Control
@onready var node1 = [
	$tanks.get_children(),
	[$Img1,$Img2,$item/item,$item2/aud],
	$"-".get_children()
	]
var node = null

func _ready():
	Soft.BindNode(node1[0]+node1[1],"mouse_entered",func(obj):node=obj)
	Soft.BindNode(node1[0]+node1[1],"mouse_exited",func(obj):node=null)
	Soft.BindNode(node1[2],"pressed",button)
	Soft.BindNode([$Img1,$Img2],"gui_input",GUI)


func _process(delta):
	$select.text = " Select: " + str(node)

func GUI(event:InputEvent):
	if event.button_mask==1:
		#var menu = OS.get_executable_path()
		$select.text = OS.get_executable_path()
		#OS.shell_open(menu)

func button(obj):
	aud(obj)
	var anmi = [$"Preview/Scene/Crate-Anim",$item/Anim]
	var l = $v1
	var g = $v2
	$item/tank.hide()
	match obj.text:
		"盾":anmi[0].animation = "armor";l.text = "护甲护盾"
		"火":anmi[0].animation = "firepowr";l.text = "火力增强"
		"疗":anmi[0].animation = "healall";l.text = "小范围\n治疗"
		"金":anmi[0].animation = "money";l.text = "获得金钱"
		"升":anmi[0].animation = "veteran";l.text = "升级"
		"载具":anmi[0].animation = "null";l.text = "免费载具";$item/tank.texture = node1[0].pick_random().texture;$item/tank.show()
		"速":anmi[0].animation = "speed";l.text = "速度提升"
		"视野":anmi[0].animation = "reveal";l.text = "全图视野"
	anmi[1].animation = anmi[0].animation
	anmi[1].stop();anmi[1].frame = 12
	anmi[0].play()
	g.text = str(obj.size.x / 3)
	
	#obj.get_theme_stylebox("normal").set_border_width_all(4)
	#obj.get_theme_stylebox("normal").set_border_color(Color("999999"))



func aud(obj):
	var sound = "res://ResPack/SoundPack/Crate/" + obj.name
	Soft.play_sfx(sound)
	$item2/aud.material["shader_parameter/intensity"] = 1.0
	await Soft.waitime(1.2)
	for i in 20:await Soft.waitime(0.002);$item2/aud.material["shader_parameter/intensity"] -= 0.04
	$item2/aud.material["shader_parameter/intensity"] = 0.0
