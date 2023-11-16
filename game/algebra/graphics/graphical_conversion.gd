extends Node


const variable_scene = preload("res://algebra/graphics/graphical_variable.tscn")
const sum_scene = preload("res://algebra/graphics/graphical_sum.tscn")


static func convert_variable(variable: AlgebraicVariable) -> GraphicalVariable:
	var new: GraphicalVariable = variable_scene.instantiate()
	new.variable_name = variable.variable_name
	if variable.is_selected:
		new.select()
	return new


static func convert_sum(sum: AlgebraicSum) -> GraphicalSum:
	var new: GraphicalSum = sum_scene.instantiate()
	var left = algebraic_to_graphical(sum.left_term)
	var right = algebraic_to_graphical(sum.right_term)
	new.add_child(left)
	new.add_child(right)
	new.left_term = left
	new.right_term = right
	if sum.is_selected:
		new.select()
	return new


static func algebraic_to_graphical(expression: AlgebraicExpression) -> GraphicalExpression:
	if expression is AlgebraicVariable:
		return convert_variable(expression)
	elif expression is AlgebraicSum:
		return convert_sum(expression)
	else:
		push_error("Conversion not implemented for %s" % expression.get_class())
		return GraphicalExpression.new()
