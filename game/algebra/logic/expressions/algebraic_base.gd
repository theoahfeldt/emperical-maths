class_name AlgebraicBase
extends Node


@export var expression: AlgebraicExpression


static func create(p_expression: AlgebraicExpression) -> AlgebraicBase:
	var new := AlgebraicBase.new()
	new.add_child(p_expression)
	new.expression = p_expression
	return new


func copy() -> AlgebraicBase:
	return AlgebraicBase.create(expression.copy())


func replace_expression(new: AlgebraicExpression) -> void:
	remove_child(expression)
	expression.queue_free()
	add_child(new)
	expression = new
