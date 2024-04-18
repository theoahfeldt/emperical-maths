class_name ExpressionInstantiator
extends Node


signal substituted_instance(instance: ManipulableExpression)

var _expression: ManipulableExpression
var _expression_creator: ExpressionCreator


func _ready() -> void:
	_expression_creator.created_expression.connect(
			_on_expression_creator_created_expression)


static func create(
		expression: ManipulableExpression, center_position: Vector2
		) -> ExpressionInstantiator:
	var new := ExpressionInstantiator.new()
	new._expression = expression
	var expression_creator := ExpressionCreator.create(center_position)
	new.add_child(expression_creator)
	new._expression_creator = expression_creator
	return new


func _on_expression_creator_created_expression(
		algebraic: AlgebraicExpression, graphical: GraphicalExpression
		) -> void:
	graphical.queue_free()
	var instance := _expression.substitute({"?": algebraic})
	print_debug("Created %s from %s" % [instance, _expression])
	substituted_instance.emit(instance)
