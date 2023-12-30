extends Node


var _level_select_menu_scene = preload("res://ui/level_select_menu.tscn")
var _level_player: LevelPlayer
var _level_select_menu: LevelSelectMenu


func _ready() -> void:
	_start_level_select_menu()


func _start_level_select_menu() -> void:
	_level_select_menu = _level_select_menu_scene.instantiate()
	add_child(_level_select_menu)
	_level_select_menu.selected.connect(_on_level_select_menu_selected)


func _on_level_select_menu_selected(level_creator: Resource) -> void:
	remove_child(_level_select_menu)
	_level_select_menu.queue_free()
	var level = level_creator.create()
	_level_player = LevelPlayer.create(level)
	add_child(_level_player)
	_level_player.cleared.connect(_on_level_player_cleared)


func _on_level_player_cleared() -> void:
	remove_child(_level_player)
	_level_player.queue_free()
	_start_level_select_menu()
