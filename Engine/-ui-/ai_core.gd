extends Control

func _ready():
	var one = [$"5_Task",$"7_Section",$DetailA]
	$page_1.connect("pressed",func():
		for i in get_children():if i is not Button:i.hide()
		for i in one:i.show())
	$page_2.connect("pressed",func():
		for i in get_children():if i is not Button:i.hide()
		$"3_Trigger".show())
