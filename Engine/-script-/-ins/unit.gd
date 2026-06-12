extends Control

const color = [Color("1a1a1a"),Color("0068cd")]

func _ready():
	for i in [$infantry,$people,$animal,$car,$tank,$ship,$plane]:
		Soft.BindNode(i.get_node("Flow").get_children(),"mouse_entered",Select)

func Select(obj):
	print(obj.get_child(0))
	#i#f obj.get_child_count()!=0:
		#var shp_file = obj.get_child(0).texture.get_path()
		#var shp = shp_file.split("/")[shp_file.split("/").size()-1]
		#Soft.Unit = shp
