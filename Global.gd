extends Node

func _ready():
	randomize()
	pause_mode = Node.PAUSE_MODE_PROCESS
	VP = get_viewport().size
	var _signal = get_tree().get_root().connect("size_changed",self,"_resize")
	reset()

var Score = 0
var time = 0
var Lives = 1
var VP = null

func _resize():
	VP = get_viewport().size

func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		var Pause_Menu = get_node_or_null("/root/Game/UI/Pause_Menu")
		if Pause_Menu == null:
			get_tree().quit()
		else:
			if get_tree().paused == true:
				print("The Pause Menu should be hidden!")
				Pause_Menu.hide()
				get_tree().paused = false
			else:
				Pause_Menu.show()
				get_tree().paused = true

func update_score(s):
	Score += s
	var HUD = get_node_or_null("/root/Game/UI/HUD")
	if HUD != null:
		HUD.update_score()

func update_lives(l):
	Lives += l
	if Lives <= 0:
		var _scene = get_tree().change_scene("res://Menus/Game_End.tscn")
	else:
		var HUD = get_node_or_null("/root/Game/UI/HUD")
		if HUD != null:
			HUD.update_lives()

func reset():
	Score = 0
	time = 30
	Lives = 5
