extends Node

var DEBUG_MODE = false
var game

func _process(_delta):
	if Input.is_action_just_pressed("ui_filedialog_refresh"):
		DEBUG_MODE = !DEBUG_MODE
