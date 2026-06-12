extends Control

@export var imageSize : Vector2
@export var title : String

func _ready():
	#name = title
	$title.text = title
	$Image.custom_minimum_size = imageSize
	$Image.size = custom_minimum_size
	z_index = 1
	$title.size.x = 160
	$"-".position.x = $title.size.x - 69
	#$line.points[0] = Vector2(-1,-1)
	#$line.points[1] = Vector2(imageSize.x+1,-1)
	#$line.points[2] = Vector2(imageSize.x+1,imageSize.y+1)
	#$line.points[3] = Vector2(-1,imageSize.y+1)

#func Drag(event:InputEvent):
	#var img = $Image.get_child(0).texture.get_size()
	#var limit = Vector4(148,69,924 - img.x - 4,487 - img.y - 27+83)
	#var box = self
	#box.position += event.relative
	#if box.position.x<limit.x:box.position.x=limit.x
	#if box.position.y<limit.y:box.position.y=limit.y
	#if box.position.x>limit.z:box.position.x=limit.z
