extends Node


const variable_scene := preload("res://algebra/graphics/graphical_variable.tscn")
const sum_scene := preload("res://algebra/graphics/graphical_sum.tscn")


static func convert_variable(variable: AlgebraicVariable) -> GraphicalExpression:
	var new: GraphicalVariable = variable_scene.instantiate()
	new.variable_name = variable.variable_name
	return new


static func convert_sum(sum: AlgebraicSum) -> GraphicalExpression:
	var left = algebraic_to_graphical(sum.left_term)
	var right = algebraic_to_graphical(sum.right_term)
	return _create_sum(left, right)


static func algebraic_to_graphical(
		expression: AlgebraicExpression) -> GraphicalExpression:
	if expression is AlgebraicVariable:
		return convert_variable(expression)
	elif expression is AlgebraicSum:
		return convert_sum(expression)
	else:
		push_error("Conversion not implemented for %s" % expression.get_class())
		return GraphicalExpression.new()


static func convert_variable_menu(
		variable: AlgebraicVariable, rules: Array) -> GraphicalExpression:
	if variable.is_selected:
		return ExpressionsMenu.from_expression(variable, rules)
	return convert_variable(variable)


static func convert_sum_menu(sum: AlgebraicSum, rules: Array) -> GraphicalExpression:
	if sum.is_selected:
		return ExpressionsMenu.from_expression(sum, rules)
	var left = algebraic_to_graphical_menu(sum.left_term, rules)
	var right = algebraic_to_graphical_menu(sum.right_term, rules)
	return _create_sum(left, right)


static func algebraic_to_graphical_menu(
		expression: AlgebraicExpression, rules: Array) -> GraphicalExpression:
	if expression is AlgebraicVariable:
		return convert_variable_menu(expression, rules)
	elif expression is AlgebraicSum:
		return convert_sum_menu(expression, rules)
	else:
		push_error("Conversion not implemented for %s" % expression.get_class())
		return GraphicalExpression.new()


static func _create_sum(
		left: GraphicalExpression, right: GraphicalExpression) -> GraphicalSum:
	var sum: GraphicalSum = sum_scene.instantiate()
	sum.add_child(left)
	sum.add_child(right)
	sum.left_term = left
	sum.right_term = right
	return sum
