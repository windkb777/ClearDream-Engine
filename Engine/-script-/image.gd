extends Control

@export var imageSize : Vector2
@export var title : String

func _ready():
	self.name = title
	$title.text = title
	$Image.custom_minimum_size = imageSize
	$Image.size = custom_minimum_size
	z_index = 1
	$title.size.x = 160
	
	$"-".position.x = $title.size.x - 69
	
	$line.points[0] = Vector2(-1,-1)
	$line.points[1] = Vector2(imageSize.x+1,-1)
	$line.points[2] = Vector2(imageSize.x+1,imageSize.y+1)
	$line.points[3] = Vector2(-1,imageSize.y+1)
	#$line.position = Vector2(1.5,imageSize.y)
	
	
	
	
