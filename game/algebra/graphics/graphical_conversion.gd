extends Node


## Converts [param expression] to the corresponding [GraphicalExpression]
static func algebraic_to_graphical(
		expression: AlgebraicExpression) -> GraphicalExpression:
	if expression is AlgebraicVariable:
		return _convert_variable(expression)
	elif expression is AlgebraicInteger:
		return _convert_integer(expression)
	elif expression is AlgebraicNegation:
		return _convert_negation(expression)
	elif expression is AlgebraicSum:
		return _convert_sum(expression)
	else:
		push_error("Conversion not implemented for %s" % expression.get_class())
		return GraphicalExpression.new()


static func _convert_variable(variable: AlgebraicVariable) -> GraphicalExpression:
	return GraphicalVariable.create(variable.variable_name)


static func _convert_integer(integer: AlgebraicInteger) -> GraphicalExpression:
	return GraphicalInteger.create(integer.value)


static func _convert_negation(negation: AlgebraicNegation) -> GraphicalExpression:
	var expression := algebraic_to_graphical(negation.expression)
	return GraphicalNegation.create(expression)


static func _convert_sum(sum: AlgebraicSum) -> GraphicalExpression:
	var left := algebraic_to_graphical(sum.left_term)
	var right := algebraic_to_graphical(sum.right_term)
	return GraphicalSum.create(left, right)
