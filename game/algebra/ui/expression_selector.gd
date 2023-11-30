class_name ExpressionSelector
extends Node


signal selected(selected_expression, mark)

var _algebraic_base: AlgebraicBase
var _graphical_base: GraphicalBase
var _mark: Array[int] = []
var _mark_stack := []


func initialize(algebraic_base, graphical_base) -> void:
	_mark = []
	_mark_stack = []
	_algebraic_base = algebraic_base
	_graphical_base = graphical_base


func process_input() -> void:
	if Input.is_action_just_pressed("expression_down"):
		mark_inner()
	if Input.is_action_just_pressed("expression_up"):
		mark_outer()
	if Input.is_action_just_pressed("expression_left"):
		mark_left()
	if Input.is_action_just_pressed("expression_right"):
		mark_right()
	if Input.is_action_just_pressed("expression_select"):
		select_expression()


func select_expression():
	selected.emit(marked_expression(), _mark)


func marked_expression() -> AlgebraicExpression:
	return ExpressionIndexer.algebraic_subexpression(_algebraic_base, _mark)


func mark_inner() -> void:
	ExpressionIndexer.move_index_in(_algebraic_base, _mark)
	update_marked()


func mark_outer() -> void:
	ExpressionIndexer.move_index_out(_mark)
	update_marked()


func mark_left() -> void:
	ExpressionIndexer.move_index_left(_algebraic_base, _mark)
	update_marked()


func mark_right() -> void:
	ExpressionIndexer.move_index_right(_algebraic_base, _mark)
	update_marked()


func push_mark_inner() -> void:
	var new_mark := _mark.duplicate()
	ExpressionIndexer.move_index_in(_algebraic_base, new_mark)
	_mark_stack.append(new_mark)


func push_mark_outer() -> void:
	var new_mark := _mark.duplicate()
	ExpressionIndexer.move_index_out(new_mark)
	_mark_stack.append(new_mark)


func push_mark_left() -> void:
	var new_mark := _mark.duplicate()
	ExpressionIndexer.move_index_left(_algebraic_base, new_mark)
	_mark_stack.append(new_mark)


func push_mark_right() -> void:
	var new_mark := _mark.duplicate()
	ExpressionIndexer.move_index_right(_algebraic_base, new_mark)
	_mark_stack.append(new_mark)


func pop_mark() -> void:
	if not _mark_stack.is_empty():
		_mark = _mark_stack.pop_back()
		update_marked()


func update_marked() -> void:
	_graphical_base.clear_color()
	var marked_graphical: GraphicalExpression = ExpressionIndexer.graphical_subexpression(
			_graphical_base, _mark)
	var marked_algebraic: AlgebraicExpression = marked_expression()
	marked_algebraic.mark()
	marked_graphical.set_color_from_algebraic(marked_algebraic)
