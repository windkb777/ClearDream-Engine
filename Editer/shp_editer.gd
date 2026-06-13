extends Control

var pal256 = null
var sel_file = null

func _ready():
	$BG.connect("pressed",func():for i in [$left/display,$left/anmi]:if i.button_pressed:$left/anime.play_backwards();i.button_pressed=false)

func ReDraw():
	print("ReDraw")



#func is_color_similar(c1:Color,c2:Color,threshold:float=0.1)->bool:
	## 计算 RGB 空间距离
	#var dr = c1.r - c2.r
	#var dg = c1.g - c2.g
	#var db = c1.b - c2.b
	#var dist = sqrt(dr*dr + dg*dg + db*db)
	#return dist < threshold
