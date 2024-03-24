extends Node2D
class_name Game

@export var debug: bool = false

func _ready():
	GlobalConfig.game = self
	if debug:
		GlobalConfig.DEBUG_MODE = true
