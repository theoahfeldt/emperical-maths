class_name ExpressionIndexer
extends Node


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


static func move_index_left(object: AlgebraicObject, index: Array[int]) -> void:
	_move_index_horizontal(object, index, -1)


static func move_index_right(object: AlgebraicObject, index: Array[int]) -> void:
	_move_index_horizontal(object, index, 1)


static func move_index_out(index: Array[int]) -> void:
	index.pop_back()


static func move_index_in(object: AlgebraicObject, index: Array[int]) -> void:
	if algebraic_subexpression(object, index).num_subexpressions() > 0:
		index.append(0)


static func algebraic_subexpression(
		object: AlgebraicObject, index: Array[int], i: int = 0
		) -> AlgebraicObject:
	if i > index.size():
		push_error("Invalid index: ", index)
	if i == index.size():
		return object
	return algebraic_subexpression(object.subexpressions()[index[i]], index, i + 1)


static func replace_algebraic_subexpression(
		object: AlgebraicObject,
		new: AlgebraicExpression,
		index: Array[int],
		i: int = 0,
		) -> void:
	if i >= index.size():
		push_error("Invalid index: ", index)
	elif i == index.size() - 1:
		object.replace_subexpression(new, index[i])
	else:
		replace_algebraic_subexpression(
				object.subexpressions()[index[i]], new, index, i + 1)


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
	object: AlgebraicObject, index: Array[int], movement) -> void:
	if index.is_empty():
		return
	var position: int = index.pop_back()
	var parent := algebraic_subexpression(object, index)
	position = clampi(position + movement, 0, parent.num_subexpressions() - 1)
	_move_index_in_position(object, index, position)


static func _move_index_in_position(
	object: AlgebraicObject, index: Array[int], position: int) -> void:
	var subexpression := algebraic_subexpression(object, index)
	if 0 <= position and position < subexpression.num_subexpressions():
		index.append(position)
	else:
		push_error("Invalid position: ", position)
