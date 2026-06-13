class_name Format
extends Panel

## SideColors 
@onready var Sides = {pal=get_tree().get_root().get_node("ClearDream/Editer").pal256,res=[],colorPos={}}
var FramesHeader = []
var FileHead = []


#region Read File Format
func ReadShp(shp_file):
	var path = shp_file
	var file = FileAccess.open(path,FileAccess.READ)
	## File Header
	var empty = file.get_16()
	var Width = file.get_16()
	var Height = file.get_16()
	var NumberOfFrames = file.get_16()
	FileHead = {size=[Width,Height],frames=NumberOfFrames}
	Soft.file.set("frames",NumberOfFrames)
	#print("Header = ",Header," Width:",Width," Height:",Height," Frames:",NumberOfFrames)
	## Frames Header
	#var FramesHeader = []
	for i in NumberOfFrames:
		var Frame = {Frame="Frame",empty="Empty",X="X",Y="Y",FWidth="FWidth",FHeight="FHeight",Flags="Flags",FColor="FColor",Reserved="Reserved",Offset="Offset"}
		Frame.Frame = "Frame " + str(i)
		Frame.X = file.get_16()
		Frame.Y = file.get_16()
		Frame.FWidth = file.get_16()
		Frame.FHeight = file.get_16()
		Frame.Flags = file.get_32() ## HasTransparency UsesRle 
		Frame.FColor = [];for f in 4:Frame.FColor.append(file.get_8()) ## RadarColor
		Frame.Reserved = file.get_32()
		Frame.Offset = file.get_32()
		FramesHeader.append(Frame)
	## 隐藏所有帧
	#for i in FramesHeader:print(i)
	DrawShp(file)
	for i in get_children():i.hide()
func ReadPal(pal_file):
	##加载读取文件
	var loader = FileAccess.get_file_as_bytes(pal_file)
	var cor = []
	##读取颜色,768/3=256,63x4=252
	for i in range(0,loader.size(),3):
		var pal_array : Array
		pal_array.append(loader.slice(i,i+3))
		var colored = Color.from_rgba8(pal_array[0][0]*4,pal_array[0][1]*4,pal_array[0][2]*4)
		cor.append(colored)
	##赋予色盘颜色
	for i in 256:
		Sides.pal[i].color = cor[i]
func ReadCSF(path):
	var file = FileAccess.open(path,FileAccess.READ)
	## header
	var fsc = "";for i in 4:fsc+=String.chr(file.get_8())
	var Ver = file.get_32()
	var NumL = file.get_32()##NumLabels
	var NumS = file.get_32()##NumStrings
	var unused = file.get_32()
	var Lang = file.get_32()
	print(fsc," Ver:",Ver," NumL:",NumL," NumS:",NumS," null:",unused," Lang:",Lang)
	for a in NumL:
		## Label header 
		var lbl = "";for i in 4:lbl+=String.chr(file.get_8())
		var NumP = file.get_32()##NumOfStrPairs
		var LenL = file.get_32()##LabelNameLength
		var L = "";for i in LenL:L+=String.chr(file.get_8())##labelName
		print(lbl," NumP:",NumP," LenL:",LenL," L:",L)
		## Values
		var type = "";for i in 4:type+=String.chr(file.get_8())
		var Lens = file.get_32()##valuelength
		var S : PackedByteArray = [];for i in Lens*2:S.append(255-file.get_8())
		var WLens = null
		var WS = ""
		#print(type,",",L,",",S.get_string_from_wchar())
		if type.contains("WRTS"):##1722
			WLens = file.get_32() ##ExtraValueLength
			WS = "";for i in WLens:WS+=String.chr(file.get_8()) ##ExtraValue
			#print(type,",",L,",",S.get_string_from_wchar(),",",WS)
		#return [L,S,WS]
		var output :PackedStringArray = [L,S.get_string_from_wchar()]
		if !WS.is_empty():output = [L,S.get_string_from_wchar(),WS]
		print(output)
 ##游程解码：恢复原字符串
func ReadPicData(pic=load("res://ResPack/recolor.png")):
	var img = {num=pic.get_image().get_data().size(),sized=pic.get_image().get_size(),colors=pic.get_image().get_data(),data=[]}
	for i in range(0,img.num,3):img.data.append(img.colors.slice(i,i+3))
	for i in 256:Sides.colorPos.set(i,[])
	## 读取像素设置
	for y in img.sized.y:
		for x in img.sized.x:
			var numOfPixels = x+y*(img.sized.x)
			var numOfColor = Color(img.data[numOfPixels][0]/255.0,img.data[numOfPixels][1]/255.0,img.data[numOfPixels][2]/255.0)
			## 对比像素颜色 与 Pal颜色的差异 颜色接近不大于阈值 就设置为Pal的颜色
			for i in 256:
				if is_color_similar(numOfColor,Sides.pal[i].color,0.16):
					Sides.colorPos[i].append(numOfPixels)
					break
			connect("draw",func():draw_rect(Rect2(x,y,1,1),numOfColor))
		for i in 16:Sides.colorPos.set("pal_%s"%i,[])
	for i in 16:for p in Sides.res.size():if Sides.res[p][0]==i:Sides.colorPos["pal_%s"%i].append(Sides.res[p][1])
#endregion 
#func ReadPicData(pic=load("res://ResPack/recolor.png")):
	#var img = {num=pic.get_image().get_data().size(),size=pic.get_image().get_size(),colors=pic.get_image().get_data(),data=[]}
	#for i in range(0,img.num,3):img.data.append(img.colors.slice(i,i+3))
	#DrawPic(Vector2(0,0),img)
#func DrawPic(offset:Vector2,datas:Dictionary):
	#for y in datas.size.y:
		#for x in datas.size.x:
			#var numOfPixels = x+y*(datas.size.x)
			#var numOfColor = Color(datas.data[numOfPixels][0]/255.0,datas.data[numOfPixels][1]/255.0,datas.data[numOfPixels][2]/255.0)
			### 对比像素颜色 与 Pal颜色的差异 颜色接近不大于阈值 就设置为Pal的颜色
			#if numOfColor!=Color.BLACK:
				#for i in 16:
					#if is_color_similar(numOfColor,Sides.pal[i].color,0.16):
						#Sides.res.append_array([[i,numOfPixels]])
				#connect("draw",func():draw_rect(Rect2(offset.x+x,offset.y+y,1,1),numOfColor))
		#for i in 16:Sides.colorPos.set("pal_%s"%i,[])
		### 优化像素颜色位置
	#for i in 16:for p in Sides.res.size():if Sides.res[p][0]==i:Sides.colorPos["pal_%s"%i].append(Sides.res[p][1])
func PaintSideColors(color):
	## 色盘着色
	const sub = "0,16,32,44,60,76,88,104,120,132,148,164,176,192,208,220"
	var n = []
	for i in sub.split(",").size():n.append(sub.split(",")[i].to_int())
	for i in Sides.pal.size():Sides.pal[i].color = color.from_rgba8(int((color*255)[0])-n[i],int((color*255)[1])-n[i],int((color*255)[2]-n[i]),255)
	## 设置
	if Input.is_anything_pressed():
		for i in 16:
			for a in Sides.colorPos["pal_%s"%i].size():
				var pixelNum = Sides.colorPos["pal_%s"%i][a]
				var pos = Vector2(pixelNum-((pixelNum / 320)*320),pixelNum / 320)
				connect("draw",func():draw_rect(Rect2(pos.x,pos.y,1,1),Sides.pal[i].color))
		queue_redraw()


func DrawShp(file):
	## Frames Data
	## 压缩方式 1完全不透明 2包含透明度(未使用RLE) 3包含透明度(采用RLE)
	for f in FramesHeader.size():
		var Data = {size=FramesHeader[f].FWidth * FramesHeader[f].FHeight,x=FramesHeader[f].FWidth,y=FramesHeader[f].FHeight,flag=FramesHeader[f].Flags,FColor=FramesHeader[f].FColor,colors=[]}
		if Data.size==0:DrawOpacity(f,FileHead)
		if Data.flag==1:
			## 压缩模式1 不压缩
			for y in Data.y:
				for x in Data.x:
					var color = file.get_8()
					#Data.colors.append(color)
					DrawCompress(x,y,f,color)
		elif Data.flag==2:
			## 压缩模式2 有透明帧 但未使用透明压缩
			## 获取头信息以外的颜色数据
			for y in Data.y:
				file.seek(file.get_position()+2)
				for x in Data.x:
					var color = file.get_8()
					#Data.colors.append(color)
					DrawTransparency(FramesHeader[f].X,FramesHeader[f].Y,f,color)
					
		elif Data.flag==3:
			## 压缩模式3 有透明帧 使用RLE压缩
			for y in Data.y:
				## 获取每行长度
				var length = file.get_16()
				## 获取每行颜色信息
				var line = ""
				for x in length-2:line+=str(file.get_8())+","
				line=line.split(",")
				## 输出结果
				var x = ""
				for i in line.size():
					if line[i-1]=="0" and line[i]!="0":
						x+="0,".repeat(line[i].to_int()-1)
					elif line[i-1]=="0" and line[i]!="0":
						x+="0,"
					else:
						x+=line[i]+","
				x=x.erase(x.length()-1)
				#x=x.erase(x.length()-1)
				## 着色
				DrawRLE(x,f,y)


#region Calc
func is_color_similar(c1:Color,c2:Color,threshold:float=0.1)->bool:
	# 计算 RGB 空间距离
	var dr = c1.r - c2.r
	var dg = c1.g - c2.g
	var db = c1.b - c2.b
	var dist = sqrt(dr*dr + dg*dg + db*db)
	return dist < threshold
#endregion

#region Draw
func DrawOpacity(f,Size):
	var frame = Panel.new();frame.name = "frame_%s"%f
	add_child(frame)
	for x in Size.size[0]:
		for y in Size.size[1]:
			frame.connect("draw",func():frame.draw_rect(Rect2(x,y,1,1),Sides.pal[0].color))
	queue_redraw()
	#print("Frame:%s "%f,"Transparency Empty Frame")
func DrawCompress(x,y,f,color):
	if x==0 and y==0:
		var Frame = Panel.new();Frame.name = "frame_%s"%f;add_child(Frame)
	var frame = get_node("frame_%s"%f)
	frame.connect("draw",func():frame.draw_rect(Rect2(x,y,1,1),Sides.pal[color].color))
	queue_redraw()
	#print("Frame:%s "%f,"Use Compress Length:",color)
func DrawTransparency(x,y,f,color):
	if x==0 and y==0:
		var Frame = Panel.new();Frame.name = "frame_%s"%f;add_child(Frame)
	var frame = get_node("frame_%s"%f)
	frame.connect("draw",func():frame.draw_rect(Rect2(x,y,1,1),Sides.pal[color].color))
	queue_redraw()
	#print("Frame:%s "%f,"Use Transparency")
func DrawRLE(result,f,y):
	if y==0:var Frame = Panel.new();Frame.name = "frame_%s"%f;add_child(Frame)
	## RLE 3
	var frame = get_node("frame_%s"%f)
	for x in result.split(",").size():
		var pos = result.split(",")[x].to_int()
		frame.connect("draw",func():frame.draw_rect(Rect2(x,y,1,1),Sides.pal[pos].color))
		frame.queue_redraw()
	queue_redraw()
	#print("Frame:%s "%f,"Use RLE Length:",length)
#region Draw
#func Draw(offset:Vector2,datas:Dictionary):
	#for y in datas.size.y:
		#for x in datas.size.x:
			#var numOfPixels = x+y*(datas.size.x)
			#var numOfColor = Color(datas.data[numOfPixels][0]/255.0,datas.data[numOfPixels][1]/255.0,datas.data[numOfPixels][2]/255.0)
			### 对比像素颜色 与 Pal颜色的差异 颜色接近不大于阈值 就设置为Pal的颜色
			#if numOfColor!=Color.BLACK:
				#for i in 16:
					#if is_color_similar(numOfColor,Sides.pal[i].color,0.16):
						#Sides.res.append_array([[i,numOfPixels]])
			### 绘制像素
			#connect("draw",func():draw_rect(Rect2(offset.x+x,offset.y+y,1,1),numOfColor))
		#for i in 16:Sides.colorPos.set("pal_%s"%i,[])
		### 优化像素颜色位置
		#for i in 16:for p in Sides.res.size():if Sides.res[p][0]==i:Sides.colorPos["pal_%s"%i].append(Sides.res[p][1])
	#wait get_tree().create_timer(0.002).timeout

func Drawshp(offset:Vector2,datas:Dictionary):
	for y in datas.y:
		for x in datas.x:
			var numOfPixels = x+y*(datas.x)
			var numOfPal = datas.colors[numOfPixels]
			connect("draw",func():draw_rect(Rect2(offset.x+x,offset.y+y,1,1),$Pal.get_child(numOfPal).color))
		queue_redraw()
		## 行渲染图像
		#await get_tree().create_timer(0.002).timeout
#endregion
