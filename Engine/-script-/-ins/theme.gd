extends Control

@onready var node = [$"0".get_children()]

const tips = [
	"游戏启动视频文件位于游戏根目录，名称为ea_wwlogo.bik,该视频如若需要替换,格式须统一为bik (Bink Video),名称同样.
	由于是视频格式,所以并不需要Pal色盘文件进行画面调色.",
	"启动封面建议替换,可以增添Mod的乐趣以及彰显定制的乐趣.如果是使用了DTA启动方式则忽略.",
	"游戏主界面循环视频,默认是30s左右的无缝循环视频,如需替换请自制Bik视频,格式名称统一即可.",
	"载入切换背景",
	"游戏内设置界面",
	"遭遇战设置背景,替换时建议能看清设置即可",
	"网络对战-1",
	"网络对战-2",
	"主菜单界面退出提示警告图,随意发挥即可!",
	"游戏胜负判定图片",
	"盟军载入过场图-1","苏联载入过场图-1","尤里载入Loading背景",
	"积分结算背景","游戏失败结算背景"
	]

func _ready():
	for i in node[0]:i.connect("pressed",button.bind(i))

func button(obj):
	obj.get_parent().texture = obj.icon
	$"tips".text = "Tips : " + tips[obj.get_index()]
	$tips.visible_ratio = 0
	for i in 100:$tips.visible_ratio += 0.01;await Soft.waitime(0.002)
	await Soft.waitime(0.6);$tips.visible_ratio = 1.0

func _on_ui_pressed():
	OS.shell_open("res://ResPack/UI_Theme/")

func _on_aud_pressed():
	OS.shell_open("res://ResPack/SoundPack/")
