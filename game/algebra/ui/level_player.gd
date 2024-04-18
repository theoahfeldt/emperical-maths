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
	_expression_controller.updated_expression.connect(
			_on_expression_controller_updated_expression)


func _on_expression_controller_updated_expression() -> void:
	var equality := _expression_controller._manipulable_base.expression
	if equality is AlgebraicEquality:
		if equality.left_expression.identical_to(equality.right_expression):
			cleared.emit()
	else:
		push_error("Base expression is not an equality")
