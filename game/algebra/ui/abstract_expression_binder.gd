class_name AbstractExpressionBinder
extends Node


signal bound(new_expression: AlgebraicExpression)

var _abstract_expression: AlgebraicExpression
var _expression_creator: ExpressionCreator


func _ready() -> void:
	_expression_creator.created_expression.connect(
			_on_expression_creator_created_expression)


static func create(
		expression: AlgebraicExpression, center_position: Vector2
		) -> AbstractExpressionBinder:
	var new := AbstractExpressionBinder.new()
	new._abstract_expression = expression
	var expression_creator := ExpressionCreator.create(center_position)
	new.add_child(expression_creator)
	new._expression_creator = expression_creator
	return new


func _on_expression_creator_created_expression(
		algebraic: AlgebraicExpression, graphical: GraphicalExpression) -> void:
	graphical.queue_free()
	var new_expression := _abstract_expression.bind({"?": algebraic})
	bound.emit(new_expression)
