extends Node


var _level_player: LevelPlayer
var _level_select_menu: LevelSelectMenu
var _center_container: CenterContainer


func _ready() -> void:
	_center_container = get_node("CenterContainer")
	_start_level_select_menu()


func _start_level_select_menu() -> void:
	_level_select_menu = LevelSelectMenu.new()
	_center_container.add_child(_level_select_menu)
	_level_select_menu.selected.connect(_on_level_select_menu_selected)


func _on_level_select_menu_selected(level_path: String) -> void:
	_center_container.remove_child(_level_select_menu)
	_level_select_menu.queue_free()
	var level_resource: Resource = load(level_path)
	var level = level_resource.create()
	_level_player = LevelPlayer.create(level)
	add_child(_level_player)
	_level_player.cleared.connect(_on_level_player_cleared)


func _on_level_player_cleared() -> void:
	remove_child(_level_player)
	_level_player.queue_free()
	_start_level_select_menu()
