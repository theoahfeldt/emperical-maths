class_name ExpressionSelector
extends Node


signal mark_updated(mark)
signal selected(mark)

const ExpressionIndexer = preload("res://algebra/expression_indexer.gd")

var base_expression: AlgebraicExpression
var _mark := []


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
	selected.emit(_mark)


func marked_expression() -> AlgebraicExpression:
	return ExpressionIndexer.algebraic_subexpression(
			base_expression, _mark)


func mark_inner() -> void:
	ExpressionIndexer.move_index_in(base_expression, _mark)
	mark_updated.emit(_mark)


func mark_outer() -> void:
	ExpressionIndexer.move_index_out(_mark)
	mark_updated.emit(_mark)


func mark_left() -> void:
	ExpressionIndexer.move_index_left(
			base_expression, _mark)
	mark_updated.emit(_mark)


func mark_right() -> void:
	ExpressionIndexer.move_index_right(
			base_expression, _mark)
	mark_updated.emit(_mark)
