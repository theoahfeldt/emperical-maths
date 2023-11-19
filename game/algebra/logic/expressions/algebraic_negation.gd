class_name AlgebraicNegation
extends AlgebraicExpression


@export var expression: AlgebraicExpression


static func create(a: AlgebraicExpression) -> AlgebraicNegation:
	var negation = AlgebraicNegation.new()
	negation.initialize(a)
	return negation


func initialize(a: AlgebraicExpression) -> void:
	add_child(a)
	expression = a


func identical_to(other: AlgebraicExpression) -> bool:
	if other is AlgebraicNegation:
		return expression.identical_to(other.expression)
	return false


func copy() -> AlgebraicExpression:
	return AlgebraicNegation.create(expression.copy())


func replace_expression(new: AlgebraicExpression) -> void:
	remove_child(expression)
	expression.queue_free()
	add_child(new)
	expression = new


func pretty_string() -> String:
	return "-%s" % expression.pretty_string()
