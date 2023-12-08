class_name ExpressionIndexer
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


static func replace_graphical_subexpression(
		base: GraphicalBase, new: GraphicalExpressionOrMenu, index: Array[int]
		) -> void:
	if index.is_empty():
		base.replace_expression(new)
	else:
		_replace_graphical_subexpression(base.expression, new, index, 0)
	base.center_smooth()


static func move_index_left(base: AlgebraicBase, index: Array[int]) -> void:
	_move_index_horizontal(base, index, -1)


static func move_index_right(base: AlgebraicBase, index: Array[int]) -> void:
	_move_index_horizontal(base, index, 1)


static func move_index_out(index: Array[int]) -> void:
	index.pop_back()


static func move_index_in(base: AlgebraicBase, index: Array[int]) -> void:
	if algebraic_subexpression(base, index).num_subexpressions() > 0:
		index.append(0)


static func _algebraic_subexpression(
		expression: AlgebraicExpression, index: Array[int], i: int
		) -> AlgebraicExpression:
	if i > index.size():
		push_error("Invalid index: ", index)
	if i == index.size():
		return expression
	return _algebraic_subexpression(
			expression.subexpressions()[index[i]], index, i + 1)


static func _replace_algebraic_subexpression(
		expression: AlgebraicExpression,
		new: AlgebraicExpression,
		index: Array[int],
		i: int,
		) -> void:
	if i >= index.size():
		push_error("Invalid index: ", index)
	elif i == index.size() - 1:
		expression.replace_subexpression(new, index[i])
	else:
		_replace_algebraic_subexpression(
				expression.subexpressions()[index[i]], new, index, i + 1)


static func _graphical_subexpression(
		expression: GraphicalExpressionOrMenu, index: Array[int], i: int
		) -> GraphicalExpressionOrMenu:
	if i > index.size():
		push_error("Invalid index: ", index)
	if i == index.size():
		return expression
	return _graphical_subexpression(
			expression.subexpressions[index[i]], index, i + 1)


static func _replace_graphical_subexpression(
		expression: GraphicalExpression,
		new: GraphicalExpressionOrMenu,
		index: Array[int],
		i: int
		) -> void:
	if i >= index.size():
		push_error("Invalid index: ", index)
	elif i == index.size() - 1:
		expression.replace_subexpression(new, index[i])
	else:
		_replace_graphical_subexpression(expression.subexpressions[index[i]], new, index, i + 1)
		expression.set_component_positions_smooth()


static func _move_index_horizontal(
	base: AlgebraicBase, index: Array[int], movement) -> void:
	if index.is_empty():
		return
	var position: int = index.pop_back()
	var parent: AlgebraicExpression = algebraic_subexpression(base, index)
	position = clampi(position + movement, 0, parent.num_subexpressions() - 1)
	_move_index_in_position(base, index, position)


static func _move_index_in_position(
	base: AlgebraicBase, index: Array[int], position: int) -> void:
	var expression: AlgebraicExpression = algebraic_subexpression(base, index)
	if 0 <= position and position < expression.num_subexpressions():
		index.append(position)
	else:
		push_error(
			"Position %d invalid for %s" % [position, expression.get_class()])
