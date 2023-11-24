class_name ExpressionSelector
extends Node


signal mark_updated(marked_expression, mark)
signal selected(selected_expression, mark)

const ExpressionIndexer = preload("res://algebra/expression_indexer.gd")

var base: AlgebraicBase
var _mark: Array[int] = []


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
	return ExpressionIndexer.algebraic_subexpression(base, _mark)


func mark_inner() -> void:
	ExpressionIndexer.move_index_in(base, _mark)
	update_marked()


func mark_outer() -> void:
	ExpressionIndexer.move_index_out(_mark)
	update_marked()


func mark_left() -> void:
	ExpressionIndexer.move_index_left(base, _mark)
	update_marked()


func mark_right() -> void:
	ExpressionIndexer.move_index_right(base, _mark)
	update_marked()


func update_marked() -> void:
	mark_updated.emit(marked_expression(), _mark)
