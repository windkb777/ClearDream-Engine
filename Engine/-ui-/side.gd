extends Control

@onready var side_mode = $"Side Mode"
@onready var tech_mode = $"Tech Mode"

@export var cameo = []
@export var Mode = 0
@export var node = null


func _ready():
	side_mode.show();tech_mode.hide()
	SideButton()
	Cameos()

## Bind
func SideButton():
	var side_button = $"Side Mode/|".get_children()
	for i in side_button:
		i.connect("gui_input",gui_input)
		i.connect("mouse_entered",func():i.modulate=Color("ffffffff");node=i;Soft.play_sfx("res://Engine/sfx/jump"))
		i.connect("mouse_exited",func():i.modulate=Color("646464"))
func Cameos():
	## add uis 2 1block array
	for i in tech_mode.get_child(2).get_child(0).get_children():for a in i.get_children():cameo.append(a)
	for i in cameo:
		i.modulate=Color("646464")
		i.connect("gui_input",gui_input)
		i.connect("mouse_entered",func():node=i;node=i)
		i.connect("mouse_exited",func():node=null)
	#print(cameo,cameo.size())

## Input Button
func gui_input(event):
	if event is InputEventMouseButton and Input.is_action_just_pressed("L_Click"):
		if Mode==0:
			var obj = tech_mode.get_node(str(node.name))
			for i in tech_mode.get_children():if !i.is_class("Panel"):i.hide()
			side_mode.hide();tech_mode.show();obj.show()
			Mode = 1
			$"../Engine/Button/A".hide()
		elif Mode==1:
			for i in cameo:i.modulate=Color("646464")
			node.modulate=Color("ffffffff")
			Soft.play_sfx("res://Engine/sfx/jump")
			print(node.name)
