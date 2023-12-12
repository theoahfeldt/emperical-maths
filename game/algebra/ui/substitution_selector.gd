class_name SubstitutionSelector
extends Node


signal substituted(new_expression: AlgebraicExpression)

var _substitution: Substitution
var _expression_creator: ExpressionCreator


func _ready() -> void:
	_expression_creator.created_expression.connect(
			_on_expression_creator_created_expression)


static func create(
		substitution: Substitution, center_position: Vector2
		) -> SubstitutionSelector:
	var new := SubstitutionSelector.new()
	new._substitution = substitution
	var expression_creator := ExpressionCreator.create(center_position)
	new.add_child(expression_creator)
	new._expression_creator = expression_creator
	return new


func _on_expression_creator_created_expression(
		algebraic: AlgebraicExpression, graphical: GraphicalExpression) -> void:
	graphical.queue_free()
	var new_expression := _substitution.substitute(algebraic)
	substituted.emit(new_expression)
