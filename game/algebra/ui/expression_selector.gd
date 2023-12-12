class_name ExpressionSelector
extends Node


signal selected(selected_expression: AlgebraicExpression, index: Array[int])

var _algebraic_base: AlgebraicBase
var _graphical_base: GraphicalBase
var _mark: Array[int] = []


func _process(_delta: float) -> void:
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


static func create(
		algebraic_base: AlgebraicBase,
		graphical_base: GraphicalBase,
		mark: Array[int] = [],
		) -> ExpressionSelector:
	var new := ExpressionSelector.new()
	new._algebraic_base = algebraic_base
	new._graphical_base = graphical_base
	new._mark = mark
	return new


func select_expression():
	if not marked_expression() is AlgebraicEquality:
		selected.emit(marked_expression(), _mark)


func marked_expression() -> AlgebraicObject:
	return _algebraic_base.subexpression(_mark)


func set_mark(mark: Array[int]) -> void:
	_mark = mark
	update_marked()


func mark_inner() -> void:
	ExpressionIndexer.move_index_in(_algebraic_base.object, _mark)
	update_marked()


func mark_outer() -> void:
	ExpressionIndexer.move_index_out(_mark)
	update_marked()


func mark_left() -> void:
	ExpressionIndexer.move_index_left(_algebraic_base.object, _mark)
	update_marked()


func mark_right() -> void:
	ExpressionIndexer.move_index_right(_algebraic_base.object, _mark)
	update_marked()


func get_mark_inner() -> Array[int]:
	var new_mark := _mark.duplicate()
	ExpressionIndexer.move_index_in(_algebraic_base.object, new_mark)
	return new_mark


func get_mark_outer() -> Array[int]:
	var new_mark := _mark.duplicate()
	ExpressionIndexer.move_index_out(new_mark)
	return new_mark


func get_mark_left() -> Array[int]:
	var new_mark := _mark.duplicate()
	ExpressionIndexer.move_index_left(_algebraic_base.object, new_mark)
	return new_mark


func get_mark_right() -> Array[int]:
	var new_mark := _mark.duplicate()
	ExpressionIndexer.move_index_right(_algebraic_base.object, new_mark)
	return new_mark


func update_marked() -> void:
	_graphical_base.clear_color()
	var marked_graphical: GraphicalExpression = ExpressionIndexer.graphical_subexpression(
			_graphical_base, _mark)
	var marked_algebraic: AlgebraicObject = marked_expression()
	marked_algebraic.mark()
	marked_graphical.set_color_from_algebraic(marked_algebraic)
