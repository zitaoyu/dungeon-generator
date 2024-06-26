extends Node

class RoomData:
	var id: int
	var x: int
	var y: int
	var is_start_room: bool
	var is_end_room: bool
	var left_room: bool
	var right_room: bool
	var top_room: bool
	var bottom_room: bool

	func _init(new_x, new_y):
		x = new_x
		y = new_y
		is_start_room = false
		is_end_room = false
		left_room = false
		right_room = false
		top_room = false
		bottom_room = false

# Size of the dungeon in terms of rooms
var DEFAULT_MAX_ROOMS = 8
var DEFAULT_DUNGEON_WIDTH = 8
var DEFAULT_DUNGEON_HEIGHT = 8
var DEFAULT_ROOM_SPAWN_CHANCE = 0.30

# 2D Array to store dungeon layout
var dungeon = []
var rooms = 0

func generate_dungeon_matrix(total_rooms=DEFAULT_MAX_ROOMS,
					max_width=DEFAULT_DUNGEON_WIDTH, 
					max_height=DEFAULT_DUNGEON_HEIGHT, 
					room_spawn_chance=DEFAULT_ROOM_SPAWN_CHANCE):
	# Clear previous dungeon matrix
	dungeon.clear()
	for y in range(max_height):
		var row = []
		for x in range(max_width):
			row.append(null)
		dungeon.append(row)
	rooms = 0
	
	# generate rooms until reach max rooms
	var queue: Array = []
	var start_x = randi_range(max_width / 4, max_width / 2)
	var start_y = randi_range(max_height / 4, max_height / 2)
	queue.append(RoomData.new(start_x, start_y))
	
	while (queue && rooms < total_rooms):
		var room_data = queue.pop_front()
		var x = room_data.x
		var y = room_data.y
		if dungeon[y][x] is RoomData:
			continue
		if rooms == 0:
			room_data.is_start_room = true
		elif rooms == total_rooms - 1:
			room_data.is_end_room = true
		connect_rooms(room_data)
		room_data.id = rooms
		dungeon[y][x] = room_data
		rooms += 1

		var randomized_direction = get_random_directions()
		var first_room = true
		while (randomized_direction):
			var d = randomized_direction.pop_front()
			var new_x = x + d.x
			var new_y = y + d.y
			var is_inbound = (new_x >= 0 and new_x < max_width and new_y >= 0 and new_y < max_height)
			if is_inbound and dungeon[new_y][new_x] == null:
				if first_room || randf() < room_spawn_chance:
					# spawn new room
					var spawn_room = RoomData.new(new_x, new_y)
					if d == Vector2(0, -1):
						spawn_room.bottom_room = true
					elif d == Vector2(0, 1):
						spawn_room.top_room = true
					elif d == Vector2(-1, 0):
						spawn_room.right_room = true
					elif d == Vector2(1, 0):
						spawn_room.left_room = true
					queue.append(spawn_room)
					first_room = false
	# return dungeon matrix
	return dungeon

func connect_rooms(room: RoomData):
	var x = room.x
	var y = room.y

	if room.left_room && dungeon[y][x - 1] is RoomData:
		dungeon[y][x - 1].right_room = true
	if room.right_room && dungeon[y][x + 1] is RoomData:
		dungeon[y][x + 1].left_room = true
	if room.top_room && dungeon[y - 1][x] is RoomData:
		dungeon[y - 1][x].bottom_room = true
	if room.bottom_room && dungeon[y + 1][x] is RoomData:
		dungeon[y + 1][x].top_room = true

func get_random_directions():
	var directions = [Vector2(0, -1), Vector2(0, 1), Vector2(-1, 0), Vector2(1, 0)]
	directions.shuffle()
	return directions

func print_last_generated_dungeon_matrix():
	print("dungeon matrix:")
	var str = ""
	for r in dungeon:
		str += "["
		for c in r:
			if c is RoomData:
				if c.is_start_room:
					str += " S "
				elif c.is_end_room:
					str += " E "
				else:
					str += " R "
			else:
				str += " * "
		str += "]\n"
	print(str)
