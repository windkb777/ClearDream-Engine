extends Panel

@onready var pathLoad = $"m/|/-/|/path"
@onready var buttons = $"m/|/-/o/0/-"
@onready var types = $"m/|/-/info".get_children()

var sel = null


func _ready():
	for i in types:if i is Button:i.connect("pressed",type.bind(i))

func LoadFile():
	$FileDialog.show()

func file_selected(path):
	var node = ["res://Input/button.gd","res://Input/input-theme.tres","res://Input/input.tres"]
	var name2 = path.split("/")
	var name3 = name2[name2.size()-1]
	var button = Button.new()
	## 设定 Button 属性
	button.text = name3;button.name = name3
	button.custom_minimum_size=Vector2(100,65)
	button.toggle_mode=true
	button.theme = load(node[1])
	button.button_group = load(node[2])
	buttons.add_child(button)
	button.set_script(load(node[0]))
	button.connect("pressed",Infos.bind(button))
	
	## 设定按钮 Flag 变量
	pathLoad.text = path
	button.flag.path = pathLoad.text
	for i in types:if i is Button and i.is_pressed():button.flag.type = i.text
	print(button)

func Infos(button):
	sel = button
	## Read Button Type
	pathLoad.text = button.flag.path
	for i in types:if i is Button and i.text==button.flag.type:i.button_pressed = true

func type(node):
	sel.flag.type = node.text
