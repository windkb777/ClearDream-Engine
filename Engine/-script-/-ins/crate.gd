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
	crate()

func GUI(event:InputEvent):
	if event.button_mask==1:
		#var menu = OS.get_executable_path()
		$select.text = OS.get_executable_path()
		#OS.shell_open(menu)

func button(obj):
	aud(obj)
	var anmi = [$"Preview/Scene/Crate-Anim",$item/Anim]
	var l = $v1
	$item/tank.hide()
	match obj.text:
		"盾":anmi[0].animation = "armor";l.text = "护甲护盾"
		"火":anmi[0].animation = "firepowr";l.text = "火力增强"
		"疗":anmi[0].animation = "healall";l.text = "小范围\n治疗"
		"金币":anmi[0].animation = "money";l.text = "获得金钱"
		"升级":anmi[0].animation = "veteran";l.text = "升级"
		"载具":anmi[0].animation = "null";l.text = "免费载具";$item/tank.texture = node1[0].pick_random().texture;$item/tank.show()
		"速":anmi[0].animation = "speed";l.text = "速度提升"
		"视野":anmi[0].animation = "reveal";l.text = "全图视野"
	anmi[1].animation = anmi[0].animation
	anmi[1].stop();anmi[1].frame = 12
	anmi[0].play()
	#g.text = str(obj.size.x / 3)
	
	#obj.get_theme_stylebox("normal").set_border_width_all(4)
	#obj.get_theme_stylebox("normal").set_border_color(Color("999999"))

func aud(obj):
	var sound = "res://ResPack/SoundPack/Crate/" + obj.name
	Soft.play_sfx(sound)
	$item2/aud.material["shader_parameter/intensity"] = 1.0
	await Soft.waitime(1.2)
	for i in 20:await Soft.waitime(0.002);$item2/aud.material["shader_parameter/intensity"] -= 0.04
	$item2/aud.material["shader_parameter/intensity"] = 0.0

##################################################################
func crate():
	var cmd = [
		Soft.md.Title("Crate rules"),
		CrateRules(),
		Soft.md.Title("Random Crate Powerups"),
		RandomCratePowerups()
	]

func CrateRules():
	var output = "[CrateRules]\n"
	for i in $flow.get_children():
		output+=i.get_child(1).name+"="+i.get_child(1).text+"\n"
	output+="FreeMCV=yes
CrateImg=Crate
WoodCrateImg=Crate
WaterCrateImg=WCRATE"
	print(output)
func RandomCratePowerups():
	var output = "[Powerups]\n"
	powerups("Armor",10,"ARMOR","yes",1.5)
	powerups("Firepower",10,"FIREPOWR","yes",1.5)
	powerups("HealBase",10,"HEALALL","yes",1.5)
	powerups("Money",20,"apple","yes",1.5)
	powerups("Reveal",30,"SKLT","yes",1.5)
	#powerups("Speed",10,"SPEED","yes",1.5)
	#powerups("Veteran",20,"VETERAN","yes",1.5)
	#powerups("Unit",20,"ARMOR","yes",1.5)
	#powerups("Invulnerability",0,"ARMOR","yes",1.5)
	#powerups("IonStorm",0,"ARMOR","yes",1.5)
	#powerups("Gas",0,"ARMOR","yes",1.5)
	#powerups("Tiberium",0,"ARMOR","yes",1.5)
	#powerups("Pod",0,"ARMOR","yes",1.5)
	#powerups("Cloak",0,"ARMOR","yes",1.5)
	#powerups("Darkness",0,"ARMOR","yes",1.5)
	#powerups("Explosion",0,"ARMOR","yes",1.5)
	#powerups("ICBM",0,"ARMOR","yes",1.5)
	#powerups("Napalm",0,"ARMOR","yes",1.5)
	#powerups("Squad",0,"ARMOR","yes",1.5)
	
func powerups(pow,percent,anmi,hasanmi,mult):
	return pow+"="+percent+","+hasanmi+","+mult

#Armor=10,ARMOR,yes,1.5              ; armor of nearby objects increased (armor multiplier);gs Think of max strength being multiplied by this (in reality, damage is divided by this since you can't change the max in Type)
#Firepower=10,FIREPOWR,yes,2.0       ; firepower of nearby objects increased (firepower multiplier)
#HealBase=10,HEALALL,yes              ; all buildings to full strength
#Money=20,apple,yes,20000             ; a chunk o' cash (maximum cash)
#Reveal=30,SKLT,yes                 ; reveal entire radar map
#Speed=10,SPEED,yes,1.2              ; speed of nearby objects increased (speed multiplier)
#Veteran=20,VETERAN,yes,1             ; veteran upgrade (levels to upgrade)
#Unit=20,<none>,no                  ; vehicle
#Invulnerability=0,ARMOR,yes,1.0     ; invulnerability (duration in minutes)
#IonStorm=0,<none>,yes               ; initiate ion storm
#Gas=0,<none>,yes,100                ; tiberium gas (damage for each gas cloud)
#Tiberium=0,<none>,no               ; tiberium patch
#Pod=0,<none>,no                    ; drop pod special
#Cloak=0,CLOAK,yes                   ; enable cloaking on nearby objects
#Darkness=0,SHROUDX,yes              ; cloak entire radar map
#Explosion=0,<none>,yes,500          ; high explosive baddie (damage per explosion)
#ICBM=100,CHEMISLE,yes                 ; nuke missile one time shot
#Napalm=0,<none>,no,600             ; fire explosion baddie (damage)
#Squad=0,<none>,no                 ; squad of random infantry
