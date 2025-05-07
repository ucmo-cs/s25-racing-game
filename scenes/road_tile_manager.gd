extends Node2D

@export var random_roadtile_fetcher: Node
@export var tile_holder: Node2D
var current_roadtiles: Array[RoadTile]
var current_exit: RoadTile.Direction
const ROADTILE_SIZE: float = 512
signal checkpoint_collected()

func _ready() -> void:
	#initialize the current_roadtiles array
	current_roadtiles = []
	#place the start tile
	place_roadtile(random_roadtile_fetcher.start_tile, Vector2(0, 0))
	current_exit = RoadTile.Direction.UP
	#create three more tiles
	for i in range(0,3):
		create_roadtile()

func create_roadtile() -> void:
	var new_roadtile: PackedScene
	var new_tile_position: Vector2 = current_roadtiles.back().position
	match current_exit:
		RoadTile.Direction.UP:
			new_roadtile = random_roadtile_fetcher.random_up_entrance_tile()
			new_tile_position.y += ROADTILE_SIZE * -1
		RoadTile.Direction.RIGHT:
			new_roadtile = random_roadtile_fetcher.random_right_entrance_tile()
			new_tile_position.x += ROADTILE_SIZE
		RoadTile.Direction.LEFT:
			new_roadtile = random_roadtile_fetcher.random_left_entrance_tile()
			new_tile_position.x -= ROADTILE_SIZE
	place_roadtile(new_roadtile, new_tile_position)

func place_roadtile(roadtile_packedscene: PackedScene, tile_position: Vector2) -> void:
	#Create the new Roadtile
	var roadtile_instance = roadtile_packedscene.instantiate()
	roadtile_instance.position = tile_position
	tile_holder.add_child(roadtile_instance)
	current_roadtiles.append(roadtile_instance)
	#Update the current_exit
	current_exit = roadtile_instance.exit
	#Connect the CheckpointCollected signal
	roadtile_instance.connect("checkpoint_collected", Callable(self, "_on_road_tile_checkpoint_collected"))
	#Create a barrier (if needed)
	if current_roadtiles.size() >= 10:
		var oldest_roadtile: RoadTile = current_roadtiles.pop_front()
		oldest_roadtile.queue_free()
		current_roadtiles[0].create_barrier()

func _on_road_tile_checkpoint_collected() -> void:
	checkpoint_collected.emit()
	create_roadtile()
