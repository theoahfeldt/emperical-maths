class_name LevelPlayer
extends Node2D


signal cleared()

var _level: Level
var _expression_controller: ExpressionController


static func create(level: Level) -> LevelPlayer:
	var new := LevelPlayer.new()
	new._level = level
	new._initialize_expression_controller()
	return new


func _initialize_expression_controller() -> void:
	_expression_controller = ExpressionController.create(
			_level.equality, _level.rules)
	add_child(_expression_controller)
	_expression_controller.updated_algebraic.connect(
			_on_expression_controller_updated_algebraic)


func _on_expression_controller_updated_algebraic() -> void:
	if _level.is_cleared():
		cleared.emit()
