extends Panel

@onready var pal = $margin/Scroll/display/pal
@onready var palGroup = [pal.get_node("RedAlert 2"),pal.get_node("Yuri's Revenge")]
@onready var PALS = [get_tree().get_nodes_in_group("pal"),get_tree().get_nodes_in_group("mult_pal")]

@onready var Sides = {pal=owner.pal256,res=[],colorPos={}}

func _ready():
	for i in palGroup:i.connect("pressed",ChangePalGroup.bind(i))
	for i in PALS[0]+PALS[1]:i.connect("pressed",ChangePal.bind(i))
	$margin/Scroll.connect("gui_input",PanRoll)

func PanRoll(event:InputEvent):
	if event.button_mask==1 and event is InputEventMouseMotion:
		$margin/Scroll.scroll_vertical -= event.relative.y

func ChangePalGroup(node):
	for i in palGroup:i.get_child(0).hide()
	node.get_child(0).show()
func ChangePal(sel):
	var sel_pal = ""
	var group = ""
	for i in palGroup:if i.get_child(0).is_visible():group = i.name
	if PALS[0].has(sel):sel_pal = sel.name + ".pal"
	if PALS[1].has(sel):
		for u in PALS[1]:if u.is_pressed() and u.get_parent().visible:sel_pal += u.name
		sel_pal += ".pal"
	### Read
	var path = "res://ResPack/Palettes/" + group + "/" + sel_pal
	$"../left/Label".text = sel_pal
	ReadPal(path)
	owner.ReDraw()
func ReadPal(pal_file):
	##加载读取文件
	var loader = FileAccess.get_file_as_bytes(pal_file)
	##读取颜色,768/3=256,63x4=252
	for i in range(0,loader.size(),3):
		var pal_array = []
		pal_array.append(loader.slice(i,i+3))
		var colored = Color.from_rgba8(pal_array[0][0]*4,pal_array[0][1]*4,pal_array[0][2]*4)
		Sides.pal[i/3].color = colored
