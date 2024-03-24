extends Node2D
class_name Room

signal player_exit

#temp
const ROOM_WIDTH = 16 * 20
const ROOM_HEIGHT = 16 * 10


@export var left_room: Room = null
@export var right_room: Room = null
@export var top_room: Room = null
@export var bottom_room: Room = null

@onready var tile_map = $TileMap
@onready var center_spawn_point = $CenterSpawnPoint
@onready var top_spawn_point = $TopSpawnPoint
@onready var bottom_spawn_point = $BottomSpawnPoint
@onready var left_spawn_point = $LeftSpawnPoint
@onready var right_spawn_point = $RightSpawnPoint

var id: int = -1
var is_start_room: bool = false
var is_end_room: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	add_doors()
	# debug
	$ID.text = str(id)

func add_doors():
	var tile_map_layer = 0
	var tile_map_cell_source_id = 0
	var tile_map_cell_atlas_coords = Vector2(3, 2)
	var tile_map_cell_alternative = 0
	#var new_tile_map_cell_position = Vector2i(0, 2)
	if left_room:
		tile_map.set_cell(tile_map_layer, Vector2i(0, 4), tile_map_cell_source_id, tile_map_cell_atlas_coords, tile_map_cell_alternative)
		tile_map.set_cell(tile_map_layer, Vector2i(0, 5), tile_map_cell_source_id, tile_map_cell_atlas_coords, tile_map_cell_alternative)
	if right_room:
		tile_map.set_cell(tile_map_layer, Vector2i(19, 4), tile_map_cell_source_id, tile_map_cell_atlas_coords, tile_map_cell_alternative)
		tile_map.set_cell(tile_map_layer, Vector2i(19, 5), tile_map_cell_source_id, tile_map_cell_atlas_coords, tile_map_cell_alternative)
	if top_room:
		tile_map.set_cell(tile_map_layer, Vector2i(9, 0), tile_map_cell_source_id, tile_map_cell_atlas_coords, tile_map_cell_alternative)
		tile_map.set_cell(tile_map_layer, Vector2i(10, 0), tile_map_cell_source_id, tile_map_cell_atlas_coords, tile_map_cell_alternative)
	if bottom_room:
		tile_map.set_cell(tile_map_layer, Vector2i(9, 9), tile_map_cell_source_id, tile_map_cell_atlas_coords, tile_map_cell_alternative)
		tile_map.set_cell(tile_map_layer, Vector2i(10, 9), tile_map_cell_source_id, tile_map_cell_atlas_coords, tile_map_cell_alternative)


func _process(_delta):
	if $ID.visible != GlobalConfig.DEBUG_MODE:
		$ID.visible = GlobalConfig.DEBUG_MODE


func _on_top_door_body_entered(body):
	if body is Player && top_room is Room:
		player_exit.emit(top_room, top_room.bottom_spawn_point.global_position)


func _on_bottom_door_body_entered(body):
	if body is Player && bottom_room is Room:
		player_exit.emit(bottom_room, bottom_room.top_spawn_point.global_position)


func _on_left_door_body_entered(body):
	if body is Player && left_room is Room:
		player_exit.emit(left_room, left_room.right_spawn_point.global_position)


func _on_right_door_body_entered(body):
	if body is Player && right_room is Room:
		player_exit.emit(right_room, right_room.left_spawn_point.global_position)
