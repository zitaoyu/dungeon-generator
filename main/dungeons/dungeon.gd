extends Node
class_name DungeonManager

@export var number_of_rooms: int
@export var dungeon_grid_width: int
@export var dungeon_grid_height: int
@export var dungeon_room_spawn_chance: float
@export var start_room: PackedScene
@export var end_room: PackedScene
@export var repeatable_rooms: bool = true
# List of load paths for room nodes. Example: "res://main/dungeons/level1/room1.tscn"
@export var room_node_pathes: PackedStringArray

@onready var player: Player = $Player
@onready var camera: Camera2D = $Camera2D


# 2D array contains RoomData
var dungeon_matrix: Array
# 2D array contains room nodes
var rooms: Array = []
var current_room: Room = null

func _ready():
	# load room nodes
	var room_nodes = []
	for path in room_node_pathes:
		var room_node: PackedScene = load(path)
		if room_node == null:
			printerr("Invalid room_node_paths. ", self)
			return
		room_nodes.append(room_node)
	room_nodes.shuffle()
	if !start_room || !end_room:
		printerr("Invalid scene path. ", self)
		return
	
	dungeon_matrix = DungeonGenerator.generate_dungeon_matrix(number_of_rooms, 
															dungeon_grid_width, 
															dungeon_grid_height,
															dungeon_room_spawn_chance)
	# initialize room nodes
	for y in range(dungeon_matrix.size()):
		var rooms_row = []
		for x in range(dungeon_matrix[0].size()):
			var room_data = dungeon_matrix[y][x]
			if room_data != null:
				var r
				if room_data.is_start_room:
					r = start_room.instantiate()
					r.is_start_room = true
				elif room_data.is_end_room:
					r = end_room.instantiate()
					r.is_end_room = true
				else:
					if repeatable_rooms:
						var i = randi_range(0, room_nodes.size() - 1)
						r = room_nodes[i].instantiate()
					else:
						r = room_nodes.pop_front().instantiate()
				r.position = Vector2(x * Room.ROOM_WIDTH, y * Room.ROOM_HEIGHT)
				r.id = room_data.id
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
			if room is Room:
				if room.is_start_room:
					current_room = room
				else:
					room.visible = false
				room.player_exit.connect(on_player_exit_room)
				add_child(room)
				
	update_current_room(current_room)
	player.position = current_room.center_spawn_point.global_position


func update_current_room(room: Room):
	room.visible = true
	current_room = room
	camera.position = room.position

func on_player_exit_room(next_room, spawn_position):
	update_current_room(next_room)
	player.position = spawn_position
