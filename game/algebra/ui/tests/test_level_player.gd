extends Node


func _ready() -> void:
	var level: Level = load("res://levels/level1.gd").create()
	var level_player := LevelPlayer.create(level)
	add_child(level_player)
	level_player.cleared.connect(_on_level_player_cleared)


func _on_level_player_cleared() -> void:
	print("Cleared!")
