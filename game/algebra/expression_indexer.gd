extends Node


static func algebraic_subexpression(base: AlgebraicBase, index: Array[int]
		) -> AlgebraicExpression:
	return _algebraic_subexpression(base.expression, index, 0)


static func replace_algebraic_subexpression(
		base: AlgebraicBase, new: AlgebraicExpression, index: Array[int]
		) -> void:
	if index.is_empty():
		base.replace_expression(new)
	else:
		_replace_algebraic_subexpression(base.expression, new, index, 0)


static func graphical_subexpression(base: GraphicalBase, index: Array[int]
		) -> GraphicalExpressionOrMenu:
	return _graphical_subexpression(base.expression, index, 0)


static func _graphical_subexpression(
		expression: GraphicalExpressionOrMenu, index: Array[int], i: int
		) -> GraphicalExpressionOrMenu:
	if i > index.size():
		push_error("Invalid index: ", index)
	if i == index.size():
		return expression
	return _graphical_subexpression(
			expression.subexpressions[index[i]], index, i + 1)


static func move_index_left(base: AlgebraicBase, index: Array[int]) -> void:
	_move_index_horizontal(base, index, -1)


static func move_index_right(base: AlgebraicBase, index: Array[int]) -> void:
	_move_index_horizontal(base, index, 1)


static func move_index_out(index: Array[int]) -> void:
	index.pop_back()


static func move_index_in(base: AlgebraicBase, index: Array[int]) -> void:
	if _num_children(algebraic_subexpression(base, index)) > 0:
		index.append(0)


static func _algebraic_subexpression(
		expression: AlgebraicExpression, index: Array[int], i: int
		) -> AlgebraicExpression:
	if i > index.size():
		push_error("Invalid index: ", i)
	if i == index.size():
		return expression
	if expression is AlgebraicNegation:
		return _algebraic_negation_subexpression(expression, index, i)
	if expression is AlgebraicSum:
		return _algebraic_sum_subexpression(expression, index, i)
	push_error("%s has no subexpression." % expression)
	return expression


static func _algebraic_negation_subexpression(
		negation: AlgebraicNegation, index: Array[int], i: int
		) -> AlgebraicExpression:
	match index[i]:
		0:
			return _algebraic_subexpression(negation.expression, index, i + 1)
		var j:
			push_error("Invalid index for negation: ", j)
			return negation


static func _algebraic_sum_subexpression(
		sum: AlgebraicSum, index: Array[int], i: int
		) -> AlgebraicExpression:
	match index[i]:
		0:
			return _algebraic_subexpression(sum.left_term, index, i + 1)
		1:
			return _algebraic_subexpression(sum.right_term, index, i + 1)
		var j:
			push_error("Invalid index for sum: ", j)
			return sum


static func _replace_algebraic_subexpression(
		expression: AlgebraicExpression, new: AlgebraicExpression, index: Array[int], i: int
		) -> void:
	if i >= index.size():
		push_error("Invalid index: ", index)
	elif expression is AlgebraicNegation:
		_replace_algebraic_negation_subexpression(expression, new, index, i)
	elif expression is AlgebraicSum:
		_replace_algebraic_sum_subexpression(expression, new, index, i)
	else:
		push_error("%s has no subexpression." % expression)


static func _replace_algebraic_negation_subexpression(
		negation: AlgebraicNegation, new: AlgebraicExpression, index: Array[int], i: int
		) -> void:
	if i == index.size() - 1:
		match index[i]:
			0:
				negation.replace_expression(new)
			var j:
				push_error("Invalid index for sum: ", j)
	else:
		match index[i]:
			0:
				_replace_algebraic_subexpression(negation.expression, new, index, i + 1)
			var j:
				push_error("Invalid index for sum: ", j)


static func _replace_algebraic_sum_subexpression(
		sum: AlgebraicSum, new: AlgebraicExpression, index: Array[int], i: int
		) -> void:
	if i == index.size() - 1:
		match index[i]:
			0:
				sum.replace_left_term(new)
			1:
				sum.replace_right_term(new)
			var j:
				push_error("Invalid index for sum: ", j)
	else:
		match index[i]:
			0:
				_replace_algebraic_subexpression(sum.left_term, new, index, i + 1)
			1:
				_replace_algebraic_subexpression(sum.right_term, new, index, i + 1)
			var j:
				push_error("Invalid index for sum: ", j)


static func _move_index_horizontal(
	base: AlgebraicBase, index: Array[int], movement) -> void:
	if index.is_empty():
		return
	var position: int = index.pop_back()
	var parent: AlgebraicExpression = algebraic_subexpression(base, index)
	position = clampi(position + movement, 0, _num_children(parent) - 1)
	_move_index_in_position(base, index, position)


static func _move_index_in_position(
	base: AlgebraicBase, index: Array[int], position: int) -> void:
	var expression: AlgebraicExpression = algebraic_subexpression(base, index)
	if 0 <= position and position < _num_children(expression):
		index.append(position)
	else:
		push_error(
			"Position %d invalid for %s" % [position, expression.get_class()])


static func _num_children(expression: AlgebraicExpression) -> int:
	if expression is AlgebraicVariable:
		return 0
	if expression is AlgebraicInteger:
		return 0
	if expression is AlgebraicNegation:
		return 1
	if expression is AlgebraicSum:
		return 2
	push_error("Method not implemented for: ", expression.get_class())
	return 0
