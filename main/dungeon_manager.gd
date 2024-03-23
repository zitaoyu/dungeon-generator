extends Node2D
class_name DungeonManager

@export var room: PackedScene = preload("res://main/room.tscn")

# 2D array contains RoomData
var dungeon_matrix: Array
# 2D array contains room nodes
var rooms: Array = []

func _ready():
	dungeon_matrix = DungeonGenerator.generate_dungeon()
	# initialize room nodes
	for y in range(dungeon_matrix.size()):
		var rooms_row = []
		for x in range(dungeon_matrix[0].size()):
			if dungeon_matrix[y][x] != null:
				var r = room.instantiate()
				r.position = Vector2(x * Room.ROOM_WIDTH, y * Room.ROOM_HEIGHT)
				rooms_row.append(r)
			else:
				rooms_row.append(null)
		rooms.append(rooms_row)

	# connect room nodes
	for y in range(dungeon_matrix.size()):
		for x in range(dungeon_matrix[0].size()):
			var room_data = dungeon_matrix[y][x]
			if room_data != null:
				if room_data.left_room:
					rooms[y][x].left_room = rooms[y][x - 1]
					rooms[y][x - 1].right_room = rooms[y][x]
				if room_data.right_room:
					rooms[y][x].right_room = rooms[y][x + 1]
					rooms[y][x + 1].left_room = rooms[y][x]
				if room_data.top_room:
					rooms[y][x].top_room = rooms[y - 1][x]
					rooms[y - 1][x].bottom_room = rooms[y][x]
				if room_data.bottom_room:
					rooms[y][x].bottom_room = rooms[y + 1][x]
					rooms[y + 1][x].top_room = rooms[y][x]

	for row in rooms:
		for room in row:
			add_child(room)

func _process(delta):
	pass
