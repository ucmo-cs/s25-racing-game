extends TileMapLayer

@export var track_pieces: Array[Vector3i]
var checkpoint_locations: Dictionary
#x = entrance, y = exit, z = difficulty
#Entrance means the place you enter it
#Exit means the place you leave it

#func _ready() -> void:
	#clear()
	#checkpoint_locations = {
		#0: Vector4(192, 256, 320, 256),
		#1: Vector4(192, 192, 320, 320),
		#2: Vector4(192, 320, 320, 192),
		#3: Vector4(256, 192, 256, 320),
		#4: Vector4(192, 320, 320, 192),
		#5: Vector4(192, 192, 320, 320),
		#6: Vector4(256, 192, 256, 320),
		## 7 does not have any checkpoints
	#}
#
#func create_trackpiece(entrance: String, exit: String, difficulty: int) -> Vector4:
	#var possible_options: Array[Vector3i] = track_pieces.duplicate()
	#
	##Up = 1, Right = 2, Down = 3, Left = 4, Start = 5
	#match entrance:
		#"Right":
			#possible_options.filter(func(vec): return vec.x == 2)
		#"Down":
			#possible_options.filter(func(vec): return vec.x == 3)
		#"Left":
			#possible_options.filter(func(vec): return vec.x == 4)
		#"Start":
			#possible_options.filter(func(vec): return vec.x == 5)
	#match exit:
		#"Up":
			#possible_options.filter(func(vec): return vec.y == 1)
		#"Right":
			#possible_options.filter(func(vec): return vec.y == 2)
		#"Left":
			#possible_options.filter(func(vec): return vec.y == 4)
	#assert(possible_options.size() >= 1, "Possible options must be bigger than 1!")
	#var chosen_option: int = randi() % possible_options.size()
	#set_pattern(Vector2.ZERO, tile_set.get_pattern(chosen_option))
	#if checkpoint_locations.has(chosen_option):
		#return checkpoint_locations[chosen_option]
	#else:
		#return Vector4.ZERO
	#
