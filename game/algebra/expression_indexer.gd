extends Node


static func algebraic_subexpression(
		expression: AlgebraicExpression, index: Array, _i: int = 0
		) -> AlgebraicExpression:
	if _i > index.size():
		push_error("Invalid index: ", _i)
	if _i == index.size():
		return expression
	if expression is AlgebraicSum:
		return _algebraic_sum_subexpression(expression, index, _i)
	push_error("%s has no subexpression." % expression)
	return expression


static func graphical_subexpression(
		expression: GraphicalExpression, index: Array, _i: int = 0
		) -> GraphicalExpression:
	if _i > index.size():
		push_error("Invalid index: ", _i)
	if _i == index.size():
		return expression
	if expression is GraphicalSum:
		return _graphical_sum_subexpression(expression, index, _i)
	push_error("%s has no subexpression." % expression)
	return expression


static func move_index_left(base: AlgebraicExpression, index: Array) -> void:
	_move_index_horizontal(base, index, -1)


static func move_index_right(base: AlgebraicExpression, index: Array) -> void:
	_move_index_horizontal(base, index, 1)


static func move_index_out(index: Array) -> void:
	index.pop_back()


static func move_index_in(base: AlgebraicExpression, index: Array) -> void:
	if _num_children(algebraic_subexpression(base, index)) > 0:
		index.append(0)


static func _algebraic_sum_subexpression(
		sum: AlgebraicSum, index: Array, i: int
		) -> AlgebraicExpression:
	match index[i]:
		0:
			return algebraic_subexpression(sum.left_term, index, i + 1)
		1:
			return algebraic_subexpression(sum.right_term, index, i + 1)
		var j:
			push_error("Invalid index for sum: ", j)
			return sum


static func _graphical_sum_subexpression(
		sum: GraphicalSum, index: Array, i: int
		) -> GraphicalExpression:
	match index[i]:
		0:
			return graphical_subexpression(sum.left_term, index, i + 1)
		1:
			return graphical_subexpression(sum.right_term, index, i + 1)
		var j:
			push_error("Invalid index for sum: ", j)
			return sum


static func _move_index_horizontal(
	base: AlgebraicExpression, index: Array, movement) -> void:
	if index.is_empty():
		return
	var position: int = index.pop_back()
	var parent: AlgebraicExpression = algebraic_subexpression(base, index)
	position = clamp(position + movement, 0, _num_children(parent))
	_move_index_in_position(base, index, position)


static func _move_index_in_position(
	base: AlgebraicExpression, index: Array, position: int) -> void:
	var expression: AlgebraicExpression = algebraic_subexpression(base, index)
	if 0 <= position and position < _num_children(expression):
		index.append(position)
	else:
		push_error(
			"Position %d invalid for %s" % [position, expression.get_class()])


static func _num_children(expression: AlgebraicExpression) -> int:
	if expression is AlgebraicVariable:
		return 0
	if expression is AlgebraicSum:
		return 2
	push_error("Method not implemented for: ", expression.get_class())
	return 0
