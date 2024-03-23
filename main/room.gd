extends Node2D
class_name Room

@export var left_room: Room = null
@export var right_room: Room = null
@export var top_room: Room = null
@export var bottom_room: Room = null


# Called when the node enters the scene tree for the first time.
func _ready(): 
	print($TileMap.get_layer_name(1))
	var tile_map = $TileMap
	var tile_map_layer = 0 
	var tile_map_cell_position = Vector2i(0,0)
	var tile_data = tile_map.get_cell_tile_data(tile_map_layer, tile_map_cell_position)
	if tile_data:
		var tile_map_cell_source_id = tile_map.get_cell_source_id(tile_map_layer, tile_map_cell_position); 
		var tile_map_cell_atlas_coords = tile_map.get_cell_atlas_coords(tile_map_layer, tile_map_cell_position) 
		var tile_map_cell_alternative = tile_map.get_cell_alternative_tile(tile_map_layer, tile_map_cell_position) 
		var new_tile_map_cell_position = tile_map_cell_position + Vector2i.RIGHT 
		tile_map.set_cell(tile_map_layer, new_tile_map_cell_position, tile_map_cell_source_id, tile_map_cell_atlas_coords, tile_map_cell_alternative)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
