extends Node


const variable_scene := preload("res://algebra/graphics/graphical_variable.tscn")
const sum_scene := preload("res://algebra/graphics/graphical_sum.tscn")


static func convert_variable(variable: AlgebraicVariable) -> GraphicalExpression:
	var new: GraphicalVariable = variable_scene.instantiate()
	new.variable_name = variable.variable_name
	return new


static func convert_sum(sum: AlgebraicSum) -> GraphicalExpression:
	var new: GraphicalSum = sum_scene.instantiate()
	var left = algebraic_to_graphical(sum.left_term)
	var right = algebraic_to_graphical(sum.right_term)
	new.add_child(left)
	new.add_child(right)
	new.left_term = left
	new.right_term = right
	return new


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
	var new: GraphicalVariable = variable_scene.instantiate()
	new.variable_name = variable.variable_name
	return new


static func convert_sum_menu(sum: AlgebraicSum, rules: Array) -> GraphicalExpression:
	if sum.is_selected:
		return ExpressionsMenu.from_expression(sum, rules)
	var new: GraphicalSum = sum_scene.instantiate()
	var left = algebraic_to_graphical_menu(sum.left_term, rules)
	var right = algebraic_to_graphical_menu(sum.right_term, rules)
	new.add_child(left)
	new.add_child(right)
	new.left_term = left
	new.right_term = right
	return new


static func algebraic_to_graphical_menu(
		expression: AlgebraicExpression, rules: Array) -> GraphicalExpression:
	if expression is AlgebraicVariable:
		return convert_variable_menu(expression, rules)
	elif expression is AlgebraicSum:
		return convert_sum_menu(expression, rules)
	else:
		push_error("Conversion not implemented for %s" % expression.get_class())
		return GraphicalExpression.new()
