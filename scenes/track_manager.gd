extends TileMapLayer

@export var checkpoint_manager: Node2D
var current_pieces: Array[TrackPiece]
var all_pieces: Array[TrackPiece]

func _ready() -> void:
	#Clear all existing tiles
	clear()
	#Create the Array of all possible TrackPieces
	all_pieces.append(TrackPiece.new(7, TrackPiece.Direction.START, TrackPiece.Direction.UP, 0, Vector2(192,256), Vector2(320,256)))
	all_pieces.append(TrackPiece.new(1, TrackPiece.Direction.UP, TrackPiece.Direction.RIGHT, 0, Vector2(192,192), Vector2(320,320)))
	all_pieces.append(TrackPiece.new(2, TrackPiece.Direction.UP, TrackPiece.Direction.LEFT, 0, Vector2(192,320), Vector2(320,192)))
	all_pieces.append(TrackPiece.new(3, TrackPiece.Direction.RIGHT, TrackPiece.Direction.RIGHT, 0, Vector2(256,192), Vector2(256,320)))
	all_pieces.append(TrackPiece.new(4, TrackPiece.Direction.LEFT, TrackPiece.Direction.UP, 0, Vector2(192,320), Vector2(320,192)))
	all_pieces.append(TrackPiece.new(5, TrackPiece.Direction.RIGHT, TrackPiece.Direction.UP, 0, Vector2(192,192), Vector2(320,320)))
	all_pieces.append(TrackPiece.new(6, TrackPiece.Direction.LEFT, TrackPiece.Direction.LEFT, 0, Vector2(256,192), Vector2(256,320)))
	all_pieces.append(TrackPiece.new(0, TrackPiece.Direction.UP, TrackPiece.Direction.UP, 0, Vector2(256,192), Vector2(256,320)))
	
	#Create the first 5 track pieces
	for i in range(6):
		create_track_piece()
	
func create_track_piece() -> void:
	#Add the track piece to the list
	if current_pieces.size() == 0:
		current_pieces.append(TrackPiece.new(7, TrackPiece.Direction.START, TrackPiece.Direction.UP, 0, Vector2(192,256), Vector2(320,256)))
		current_pieces[0].piece_grid_position = Vector2i(0,0)
		place_piece_in_position(current_pieces[0])
	else:
		var piece_filter = all_pieces.duplicate()
		print("Piece Filter1:")
		for i in piece_filter:
			print(i.piece_entrance)
		var previous_piece: TrackPiece = current_pieces[current_pieces.size() - 1].duplicate_piece()
		#Get the direction of the previous piece and use it to determine the next one
		var next_grid_position_offset: Vector2i
		match previous_piece.piece_exit:
			TrackPiece.Direction.UP:
				#piece_filter.filter(func(x): return x.piece_entrance == TrackPiece.Direction.UP)
				for i in range(piece_filter.size() -1, -1, -1):
					if piece_filter[i].piece_entrance != TrackPiece.Direction.UP:
						piece_filter.remove_at(i)
				next_grid_position_offset = Vector2i(0, 1)
			TrackPiece.Direction.RIGHT:
				#piece_filter.filter(func(x): return x.piece_entrance == TrackPiece.Direction.RIGHT)
				for i in range(piece_filter.size() -1, -1, -1):
					if piece_filter[i].piece_entrance != TrackPiece.Direction.RIGHT:
						piece_filter.remove_at(i)
				next_grid_position_offset = Vector2i(1, 0)
			TrackPiece.Direction.DOWN:
				for i in range(piece_filter.size() -1, -1, -1):
					if piece_filter[i].piece_entrance != TrackPiece.Direction.DOWN:
						piece_filter.remove_at(i)
				#piece_filter.filter(func(x): return x.piece_entrance == TrackPiece.Direction.DOWN)
				next_grid_position_offset = Vector2i(0, -1)
			TrackPiece.Direction.LEFT:
				for i in range(piece_filter.size() -1, -1, -1):
					if piece_filter[i].piece_entrance != TrackPiece.Direction.LEFT:
						piece_filter.remove_at(i)
				#piece_filter.filter(func(x): return x.piece_entrance == TrackPiece.Direction.LEFT)
				next_grid_position_offset = Vector2i(-1, 0)
		#Choose a random piece out of the leftover options to be the next piece
		print("Piece Filter2:")
		for i in piece_filter:
			print(i.piece_entrance)
		current_pieces.append(piece_filter[randi_range(0, piece_filter.size() - 1)].duplicate_piece())
		#Set the new grid piece's grid position
		current_pieces[current_pieces.size() - 1].piece_grid_position = previous_piece.piece_grid_position + next_grid_position_offset
		#Place the piece in position
		place_piece_in_position(current_pieces[current_pieces.size() - 1])
		
		if current_pieces.size() > 6:
			current_pieces.remove_at(0)
			#Place a barrier at current_pieces[1], when that functionality is ready
	
func place_piece_in_position(track_piece: TrackPiece) -> void:
	#Prepare all the positions for their global position
	var global_piece_position: Vector2i = track_piece.piece_grid_position * Vector2i(16, -16) #This is the top left corner of the piece
	track_piece.piece_checkpoint_position1 *= Vector2(track_piece.piece_grid_position) * Vector2(1, -1)
	track_piece.piece_checkpoint_position2 *= Vector2(track_piece.piece_grid_position) * Vector2(1, -1)
	#Place the tiles
	set_pattern(global_piece_position, tile_set.get_pattern(track_piece.piece_pattern_id))
	#Place the checkpoint
	checkpoint_manager.create_checkpoint(track_piece.piece_checkpoint_position1, track_piece.piece_checkpoint_position2)

func _on_checkpoint_checkpoint_collected() -> void:
	create_track_piece()
