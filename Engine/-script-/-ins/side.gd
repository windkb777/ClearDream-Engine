extends Control

#@onready var button = [$side.get_children(),$side/GDI/country.get_children(),$side/GDI/tech.get_children()]

var output = {}

func _ready():
	#for i in button[0]:i.connect("pressed",buttons.bind(i))
	CountrySide()

#func buttons(node):
	#ChangeGroup()
#
#func ChangeGroup():
	#for i in button[0].size():
		#if button[0][i].is_pressed():
			#button[0][i].modulate = Color.WHITE
			#button[1][i].show()
			#button[2][i].show()
		#else:
			#button[0][i].modulate = Color.DIM_GRAY
			#button[1][i].hide()
			#button[2][i].hide()

func _on_add_set_pressed():
	var box = load("res://Confirm.tscn").instantiate()
	add_child(box)
	box.z_index = 2

##########################################################
func CountrySide():
	var cmd = [
		Soft.md.Title("Side Type List","C"),
		side()+"\n",
		Soft.md.Title("Country Statistics"),
		country(),
		"\nCTVYTGBUHNJI"
		]
	for i in cmd:print(i)

func side():
	var sides = $side.get_children()
	var ans =  "[Sides]"
	for i in sides:
		var country = i.get_children()[0].get_children()
		var array = []
		for a in country:array.append(a.text.dedent().replacen("\n",""))
		output.set(i.name,array)
		ans+="\n"+i.name+"="+",".join(array)
	return ans
func country():
	var sides = $side.get_children()
	var ans =  ""
	for i in sides:
		var count = i.get_children()[0].get_children()
		for a in count:
			var ed = a.editor_description.split(",")
			var countrys = a.text.dedent().replacen("\n","")
			var space = ""
			if countrys!="Americans":space="\n"
			var cy = "
			%s[%s]
			UIName=Name:%s
			Suffix=%s
			Prefix=%s
			Color=%s
			Side=%s
			SmartAI=yes
			Multiplay=true".dedent() % [space,countrys,countrys,ed[0],ed[1],ed[2],ed[3]]
			ans+=cy
	return ans
