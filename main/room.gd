extends Node2D
class_name Room

#temp
const ROOM_WIDTH = 16 * 5
const ROOM_HEIGHT = 16 * 5

@export var left_room: Room = null
@export var right_room: Room = null
@export var top_room: Room = null
@export var bottom_room: Room = null
@onready var tile_map = $TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	add_doors()

func add_doors():
	var tile_map_layer = 0
	var tile_map_cell_source_id = 0
	var tile_map_cell_atlas_coords = Vector2(3, 2)
	var tile_map_cell_alternative = 0
	#var new_tile_map_cell_position = Vector2i(0, 2)
	if left_room:
		tile_map.set_cell(tile_map_layer, Vector2i(0, 2), tile_map_cell_source_id, tile_map_cell_atlas_coords, tile_map_cell_alternative)
	if right_room:
		tile_map.set_cell(tile_map_layer, Vector2i(4, 2), tile_map_cell_source_id, tile_map_cell_atlas_coords, tile_map_cell_alternative)
	if top_room:
		tile_map.set_cell(tile_map_layer, Vector2i(2, 0), tile_map_cell_source_id, tile_map_cell_atlas_coords, tile_map_cell_alternative)
	if bottom_room:
		tile_map.set_cell(tile_map_layer, Vector2i(2, 4), tile_map_cell_source_id, tile_map_cell_atlas_coords, tile_map_cell_alternative)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
