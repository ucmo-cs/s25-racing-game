extends Node

#Global Assistants
@export var backgroundcanvaslayer: CanvasLayer
@export var uicanvaslayer: CanvasLayer
@export var gameholder: Node
#PackedScenes
@export var roadtile_manager_scene: PackedScene
@export var player_car_scene: PackedScene
@export var game_background_scene: PackedScene
@export var game_ui_scene: PackedScene
@export var start_menu_scene: PackedScene
@export var gameover_menu_scene: PackedScene
@export var point_counter_scene: PackedScene

#Global Signals
signal global_player_speed(speed: float)
signal global_checkpoint_collected()
signal global_out_of_time()
signal global_game_over()
signal global_points_earned(points: int)

func _ready() -> void:
	start_main_menu()

func start_main_menu() -> void:
	var start_menu_scene_instance = start_menu_scene.instantiate()
	uicanvaslayer.add_child(start_menu_scene_instance)
	start_menu_scene_instance.connect("start_button_pressed", Callable(self, "_on_start_menu_button_pressed"))

func start_gameplay() -> void:
	#Add 2D Elements
	var roadtile_manager_scene_instance = roadtile_manager_scene.instantiate()
	gameholder.add_child(roadtile_manager_scene_instance)
	roadtile_manager_scene_instance.connect("checkpoint_collected", Callable(self, "_on_checkpoint_collected"))
	var player_car_scene_instance = player_car_scene.instantiate()
	gameholder.add_child(player_car_scene_instance)
	player_car_scene_instance.connect("player_speed", Callable(self, "_on_player_speed")) #Car to self
	var point_counter_scene_instance = point_counter_scene.instantiate()
	gameholder.add_child(point_counter_scene_instance)
	point_counter_scene_instance.connect("points_earned", Callable(self, "_on_points_earned"))
	global_game_over.connect(Callable(point_counter_scene_instance, "_on_game_over"))
	#Add UI Elements
	var game_ui_scene_instance = game_ui_scene.instantiate()
	uicanvaslayer.add_child(game_ui_scene_instance)
	game_ui_scene_instance.connect("out_of_time", Callable(self, "_on_out_of_time"))
	global_checkpoint_collected.connect(Callable(game_ui_scene_instance, "_on_global_checkpoint_collected"))
	global_player_speed.connect(Callable(game_ui_scene_instance, "_on_global_player_speed"))
	
	var game_background_scene_instance = game_background_scene.instantiate()
	backgroundcanvaslayer.add_child(game_background_scene_instance)

func start_game_over_menu() -> void:
	var gameover_menu_scene_instance = gameover_menu_scene.instantiate()
	uicanvaslayer.add_child(gameover_menu_scene_instance)
	gameover_menu_scene_instance.connect("main_menu_button_pressed", Callable(self, "_on_main_menu_button_pressed"))
	gameover_menu_scene_instance.connect("try_again_button_pressed", Callable(self, "_on_try_again_button_pressed"))
	global_game_over.emit()

func obliterate_current_state() -> void:
	for i in backgroundcanvaslayer.get_children():
		i.queue_free()
	for i in gameholder.get_children():
		i.queue_free()
	for i in uicanvaslayer.get_children():
		i.queue_free()

#Signals-------

func _on_main_menu_button_pressed() -> void:
	obliterate_current_state()
	start_main_menu()

func _on_try_again_button_pressed() -> void:
	obliterate_current_state()
	start_gameplay()

func _on_out_of_time() -> void:
	obliterate_current_state()
	start_game_over_menu()

func _on_points_earned(points: int) -> void:
	global_points_earned.emit(points)

func _on_player_speed(speed: float) -> void:
	global_player_speed.emit(speed)

func _on_checkpoint_collected() -> void:
	global_checkpoint_collected.emit()

func _on_start_menu_button_pressed() -> void:
	obliterate_current_state()
	start_gameplay()
