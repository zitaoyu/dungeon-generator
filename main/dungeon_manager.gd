extends Node2D
class_name DungeonManager

@export var room: PackedScene = preload("res://main/room.tscn")

var dungeon_matrix: Array

#temp
var room_w = 16 * 5
var room_h = 16 * 5
var tile_size = 16

func _ready():
	dungeon_matrix = DungeonGenerator.generate_dungeon()
	for y in range(dungeon_matrix.size()):
		for x in range(dungeon_matrix[0].size()):
			if dungeon_matrix[y][x] != null:
				var r = room.instantiate()
				r.position = Vector2(x * room_w, y * room_h)
				add_child(r)

func _process(delta):
	pass
