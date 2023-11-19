extends Node


const variable_scene := preload("res://algebra/graphics/expressions/graphical_variable.tscn")
const integer_scene := preload("res://algebra/graphics/expressions/graphical_integer.tscn")
const negation_scene := preload("res://algebra/graphics/expressions/graphical_negation.tscn")
const sum_scene := preload("res://algebra/graphics/expressions/graphical_sum.tscn")


## Converts [param expression] to the corresponding [GraphicalExpression]. If
## the optional parameter [param menu_rules] is set, the subexpression [code] e
## [\code] of [param expression] with [code] e.is_selected = true [/code] will
## be replaced by: [code]
## [method.ExpressionsMenu.from_expression](e, [param menu_rules]) [/code].
static func algebraic_to_graphical(
		expression: AlgebraicExpression, menu_rules := []) -> GraphicalExpression:
	if not menu_rules.is_empty() and expression.is_selected:
		return ExpressionsMenu.from_expression(expression, menu_rules)
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
	var new: GraphicalVariable = variable_scene.instantiate()
	new.variable_name = variable.variable_name
	return new


static func _convert_integer(integer: AlgebraicInteger) -> GraphicalExpression:
	var new: GraphicalInteger = integer_scene.instantiate()
	new.value = integer.value
	return new


static func _convert_negation(
		negation: AlgebraicNegation, menu_rules: Array) -> GraphicalExpression:
	var new: GraphicalNegation = negation_scene.instantiate()
	var expression := algebraic_to_graphical(negation.expression, menu_rules)
	new.add_child(expression)
	new.expression = expression
	return new


static func _convert_sum(sum: AlgebraicSum, menu_rules: Array) -> GraphicalExpression:
	var new: GraphicalSum = sum_scene.instantiate()
	var left := algebraic_to_graphical(sum.left_term, menu_rules)
	var right := algebraic_to_graphical(sum.right_term, menu_rules)
	new.add_child(left)
	new.add_child(right)
	new.left_term = left
	new.right_term = right
	return new
