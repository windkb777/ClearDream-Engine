extends AnimatedSprite2D

@onready var pal = $"../Pal_group".get_children()

func _ready():
	animatedSpriteData()
	
	#get_
func animatedSpriteData(sprite=self):
	
	var data = sprite.sprite_frames.get_frame_texture(sprite.animation,sprite.frame).get_image()
	var img = {num=data.get_data_size(),size=data.get_size(),colors=data.get_data(),data=[]}
	for i in range(0,img.num,3):img.data.append(img.colors.slice(i,i+3))
	#var bg_color = [Color.BLUE,Color("fc00fc")]
	var fix = {};for i in 256:fix.set("pal_%s"%i,[])
	var child = Panel.new();child.name="ID";add_child(child);child.z_index=2
	for y in img.size.y:
		for x in img.size.x:
			var numOfPixels = x+y*(img.size.x)
			var numOfColor = Color(img.data[numOfPixels][0]/255.0,img.data[numOfPixels][1]/255.0,img.data[numOfPixels][2]/255.0)
			for i in 256:
				if is_color_similar(numOfColor,pal[i].color,0.16):
					fix["pal_%s"%i].append(numOfPixels)
					break
	for i in fix.values():
		print(i.size())
	
	
	
func is_color_similar(c1:Color,c2:Color,threshold:float=0.1)->bool:
	# 计算 RGB 空间距离
	var dr = c1.r - c2.r
	var dg = c1.g - c2.g
	var db = c1.b - c2.b
	var dist = sqrt(dr*dr + dg*dg + db*db)
	return dist < threshold
