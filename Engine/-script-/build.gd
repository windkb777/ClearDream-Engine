extends Control

@onready var obj = $gdi.get_children() + $base.get_children()

var sel = null
func _ready():
	for i in obj:
		if i is TextureRect:
			i.connect("mouse_entered",func():sel=i)
			i.connect("mouse_exited",func():sel=null)
			i.connect("gui_input",Mouse)
	for i in $neutral.get_children():
		i.get_child(0).connect("mouse_entered",func():sel=i.get_child(0))
		i.get_child(0).connect("mouse_exited",func():sel=null)
		i.get_child(0).connect("gui_input",Mouse)

func Mouse(event:InputEvent):
	if event is InputEventMouseButton and event.double_click==true:
		print(sel.name)
