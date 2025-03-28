class_name TrackPiece
extends Resource

enum Direction {UP, RIGHT, DOWN, LEFT, START}

var piece_pattern_id: int
var piece_entrance: Direction
var piece_exit: Direction
var piece_difficulty: int
var piece_grid_position: Vector2i
var piece_checkpoint_position1: Vector2
var piece_checkpoint_position2: Vector2

func _init(pattern_id: int, entrance: Direction, exit: Direction, difficulty: int, checkpoint_position1: Vector2, checkpoint_position2: Vector2, grid_position: Vector2i = Vector2i(-1,-1)) -> void:
	piece_pattern_id = pattern_id
	piece_entrance = entrance
	piece_exit = exit
	piece_difficulty = difficulty
	piece_grid_position = grid_position
	piece_checkpoint_position1 = checkpoint_position1
	piece_checkpoint_position2 = checkpoint_position2

func duplicate_piece() -> TrackPiece:
	return TrackPiece.new(piece_pattern_id,piece_entrance,piece_exit,piece_difficulty,piece_checkpoint_position1,piece_checkpoint_position2,piece_grid_position)
