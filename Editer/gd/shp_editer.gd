extends Control

var pal256 = null
var sel_file = null

func _ready():
	$BG.connect("focus_entered",func():print("bg");for i in [$left/display,$left/anmi]:if i.button_pressed:$left/anime.play_backwards();i.button_pressed=false)

func ReDraw():
	var imgs = Soft.file.windows[0].imgs
	for i in imgs.get_children():i.queue_redraw()
	imgs.get_theme_stylebox("panel").bg_color = pal256[0].color
	print("ReDraw")

func _on_gui_input(event):
	if Input.is_action_pressed("MUP"):
		$TimeLine/RPad.scroll_horizontal+=1
	elif Input.is_action_pressed("MDown"):
		$TimeLine/RPad.scroll_horizontal-=1
