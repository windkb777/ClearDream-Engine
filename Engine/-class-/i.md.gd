class_name Ra2md
extends Node

#### Ra2 标题语法 ####
func Title(label,startype:String="B"):
	var star:String
	match startype:
		"B":star =  " ******* "
		"C":star =  " *** "
		"A":star =  "; **************************************************************************\n; **************************** %s ************************************\n; **************************************************************************\n"%label
	var cmd = ";"+star+label.replace(";","")+star
	if label.contains("["):cmd=label
	if startype=="A":cmd=star
	return cmd

func Split_Type(content:String):
	var cmd = "******* %s *******"%content
	return cmd

func eco(a,b,c=""):
	var con = a+"="+b
	if !c.is_empty():con+="			"+c
	return con

## Yuri's Revenge RulesMD.ini 编写栏





const HardColor="[ColorAdd]"
