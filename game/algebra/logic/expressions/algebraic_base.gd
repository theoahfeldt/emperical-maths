class_name AlgebraicBase
extends Node


@export var expression: AlgebraicExpression


func replace_expression(new: AlgebraicExpression) -> void:
	remove_child(expression)
	expression.queue_free()
	add_child(new)
	expression = new
