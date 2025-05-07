extends Polygon2D

#@export var ribbon_width: float
#@export var first_position: Vector2
#@export var second_position: Vector2
#@export var length_to_vertex_ratio: float #one vertex for every [input] unit(s)
@export var ribbon_fade_animationplayer: AnimationPlayer

#func _ready() -> void:
	#set_ribbon_position(first_position, second_position)

func fade() -> void:
	ribbon_fade_animationplayer.play("fade")

#func set_ribbon_position(position1: Vector2, position2: Vector2):
	#first_position = position1
	#second_position = position2
	#
	##Calculate the direction of the Ribbon
	#var ribbon_direction: Vector2 = (first_position - second_position).normalized()
	##Calculate the perpendicular direction of the Ribbon
	#var ribbon_perpendicular_direction: Vector2 = Vector2(-1 * ribbon_direction.y, ribbon_direction.x)
	##Extend the length of the perpendicular direction to match half the Ribbon's width
	#ribbon_perpendicular_direction *= ribbon_width / 2
	#
	##Calculate the side length of the ribbon
	#var ribbon_length: float = sqrt(pow(second_position.x - first_position.x, 2) + pow(second_position.y - first_position.y, 2))
	##Calculate how many vertexes can fit on the side
	#var ribbon_side_vertex_count: int = floor((ribbon_length / length_to_vertex_ratio))
	##Calculate the space between each side vertex
	#var ribbon_space_between_side_vertexes: float = ribbon_length / float(ribbon_side_vertex_count - 1)
	#
	##Calculate the slope of the length side
	#var ribbon_side_slope: Vector2 = Vector2(second_position.x - first_position.x, second_position.y - first_position.y)
	#var ribbon_side_vertex_delta: Vector2 = ribbon_side_slope.normalized() * ribbon_space_between_side_vertexes
	#
	##Create the list of Vertices that will later be going into polygon
	#var vertex_list: Array = []
	##Add the Bottom Left and Top Left vertices to the list
	#vertex_list.append(Vector2(first_position - ribbon_perpendicular_direction)) #Bottom Left
	#vertex_list.append(Vector2(first_position + ribbon_perpendicular_direction)) #Top Left
	##Add all the side vertices on the Top Side
	#var current_vertex_position: Vector2 = vertex_list[vertex_list.size() - 1]
	#for i in range(1, ribbon_side_vertex_count):
		#current_vertex_position += ribbon_side_vertex_delta
		#vertex_list.append(current_vertex_position)
	##Add the Top Right and Bottom Right vertices to the list
	#vertex_list.append(second_position + ribbon_perpendicular_direction)
	#vertex_list.append(second_position - ribbon_perpendicular_direction)
	##Add all the side vertices on the Bottom Side
	#current_vertex_position = vertex_list[vertex_list.size() - 1]
	#for i in range(1, ribbon_side_vertex_count):
		#current_vertex_position += -1 * ribbon_side_vertex_delta
		#vertex_list.append(current_vertex_position)
	##Close the loop
	#vertex_list.append(vertex_list[0])
	##Set polygon to the vertex list
	#polygon = vertex_list.duplicate()

func _on_ribbon_fade_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
