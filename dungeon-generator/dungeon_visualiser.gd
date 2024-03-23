extends Control

# Tile size
const TILE_SIZE = 64
@onready var dungeon = DungeonGenerator.dungeon

func _draw():
	for y in range(dungeon.size()):
		for x in range(dungeon[0].size()):
			var room = dungeon[y][x]
			if room != null:
				# Draw the room
				draw_rect(Rect2(x * TILE_SIZE, y * TILE_SIZE, TILE_SIZE, TILE_SIZE), Color.GREEN, false)

				# Draw connections
				if room.left_room:
					draw_line(Vector2(x * TILE_SIZE + TILE_SIZE / 2, y * TILE_SIZE + TILE_SIZE / 2),
							  Vector2(x * TILE_SIZE, y * TILE_SIZE + TILE_SIZE / 2),
							  Color.RED)
				if room.right_room:
					draw_line(Vector2(x * TILE_SIZE + TILE_SIZE / 2, y * TILE_SIZE + TILE_SIZE / 2),
							  Vector2(x * TILE_SIZE + TILE_SIZE, y * TILE_SIZE + TILE_SIZE / 2),
							  Color.RED)
				if room.top_room:
					draw_line(Vector2(x * TILE_SIZE + TILE_SIZE / 2, y * TILE_SIZE + TILE_SIZE / 2),
							  Vector2(x * TILE_SIZE + TILE_SIZE / 2, y * TILE_SIZE),
							  Color.RED)
				if room.bottom_room:
					draw_line(Vector2(x * TILE_SIZE + TILE_SIZE / 2, y * TILE_SIZE + TILE_SIZE / 2),
							  Vector2(x * TILE_SIZE + TILE_SIZE / 2, y * TILE_SIZE + TILE_SIZE),
							  Color.RED)
			else:
				draw_rect(Rect2(x * TILE_SIZE, y * TILE_SIZE, TILE_SIZE, TILE_SIZE), Color.ALICE_BLUE)

func _on_button_pressed():
	DungeonGenerator.generate_dungeon()
	dungeon = DungeonGenerator.dungeon
	DungeonGenerator.dungeon_to_string()
	get_tree().reload_current_scene()
