extends VBoxContainer

@onready var imgs = $"|/Image"



func _ready():
	## Bind Button
	for i in $"title/|".get_children():i.connect("pressed",button.bind(i))
	## Draw BG_Color
	imgs.get_theme_stylebox("panel").bg_color = get_parent().get_parent().get_node("Editer").pal256[0].color
	## Drag_Bind
	$title.connect("gui_input",Drag)
	CheckSize()

func BorderLine():
	var line = $line
	var imageSize = $Image.size
	line.points[0] = Vector2(-1,-1)
	line.points[1] = Vector2(imageSize.x+1,-1)
	line.points[2] = Vector2(imageSize.x+1,imageSize.y+1)
	line.points[3] = Vector2(-1,imageSize.y+1)

func Drag(event:InputEvent):
	if event.button_mask==1 and event is InputEventMouseMotion:
		var limit = Vector4(149,68,924-size.x,489-size.y-128)
		var box = self
		box.position += event.relative
		if box.position.x<limit.x:box.position.x=limit.x#;print("左")
		if box.position.y<limit.y:box.position.y=limit.y#;print("上")
		if box.position.x>limit.z:box.position.x=limit.z#;print("右")
		if box.position.y>limit.w:box.position.y=limit.w#;print("下")

func button(node):	
	match node.name:
		"close":
			for i in Soft.file.windows:i.queue_free();
			Soft.file.windows = []
			


func CheckSize():
	$"|/Image".position = Vector2.ZERO
	if imgs.size <= Vector2(60,40):
		print("Check Success! \nIt's Small Pad!")
	else:
		$"title/|".position.x = imgs.size.x - 70 
		size.x = imgs.size.x
		$"|/Panel".size.x = imgs.size.x
		$line.points[1].x = imgs.size.x + 2;$line.points[2].x = imgs.size.x + 2
		$line.points[2].y = imgs.size.y + 2 + 24;$line.points[3].y = imgs.size.y + 2 + 24
		print("Check Success! \nIt's Big Pad!")
