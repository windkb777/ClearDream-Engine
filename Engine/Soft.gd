extends Node

#var game_path = OS.get_executable_path()
@onready var md = Ra2md.new()
#var SmallUIs = {}
var file = {windows=[],layer=[1,0],frames=0}


## Global Function
func play_sfx(path):
	var sfx = AudioStreamPlayer.new()
	sfx.connect("finished",sfx.queue_free)
	add_child(sfx)
	sfx.volume_db = randf_range(-12,0)
	#sfx.stream = load("res://Engine/sfx/"+path+)
	sfx.stream = load(path + ".wav")
	sfx.play()
func waitime(time):
	await get_tree().create_timer(time).timeout
## Simple Func
func BindNode(nodes,signals,funcs):
	if nodes is Array:
		for i in nodes:
			if signals!="gui_input":i.connect(signals,funcs.bind(i))
			if signals=="gui_input":i.connect(signals,funcs)
	elif nodes is Button:nodes.connect(signals,funcs)
