extends Control

#@export var Title : String = "Test.shp"
#@export var Size : Vector2 = size
#@export var img : PackedStringArray = ["res://z.gdset/ui_ico/recolor.png"]

#func _ready():
	#$title.text = Title
	#name = Title
	#Size = $Image.size


#func image_type(type):
	#var orgin_pixel = get_child(2).texture.get_size()
	#var bg = get_child(3)
	#var img = get_child(2)
	#match type:
		#"sprites":size =  Vector2(orgin_pixel.x / img.hframes,orgin_pixel.y / img.vframes)
	#bg.size = size

#func _input(event):
	#Input.set_custom_mouse_cursor($Brut2.texture,Input.CURSOR_HSIZE)
