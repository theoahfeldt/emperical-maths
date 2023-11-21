extends Node


## Converts [param expression] to the corresponding [GraphicalExpression]. If
## the optional parameter [param menu_rules] is set, the subexpression [code] e
## [\code] of [param expression] with [code] e.is_selected = true [/code] will
## be replaced by: [code]
## [method.ExpressionMenu.from_expression](e, [param menu_rules]) [/code].
static func algebraic_to_graphical(
		expression: AlgebraicExpression, menu_rules: Array[AlgebraicRule] = []
		) -> GraphicalExpressionOrMenu:
	if not menu_rules.is_empty() and expression.is_selected:
		return ExpressionMenu.from_expression(expression, menu_rules)
	if expression is AlgebraicVariable:
		return _convert_variable(expression)
	elif expression is AlgebraicInteger:
		return _convert_integer(expression)
	elif expression is AlgebraicNegation:
		return _convert_negation(expression, menu_rules)
	elif expression is AlgebraicSum:
		return _convert_sum(expression, menu_rules)
	else:
		push_error("Conversion not implemented for %s" % expression.get_class())
		return GraphicalExpression.new()


static func _convert_variable(variable: AlgebraicVariable) -> GraphicalExpression:
	return GraphicalExpression.variable(variable.variable_name)


static func _convert_integer(integer: AlgebraicInteger) -> GraphicalExpression:
	return GraphicalExpression.integer(integer.value)


static func _convert_negation(
		negation: AlgebraicNegation, menu_rules: Array[AlgebraicRule]
		) -> GraphicalExpression:
	var expression := algebraic_to_graphical(negation.expression, menu_rules)
	return GraphicalExpression.negation(expression)


static func _convert_sum(
		sum: AlgebraicSum, menu_rules: Array[AlgebraicRule]
		) -> GraphicalExpression:
	var left := algebraic_to_graphical(sum.left_term, menu_rules)
	var right := algebraic_to_graphical(sum.right_term, menu_rules)
	return GraphicalExpression.sum(left, right)
