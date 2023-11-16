class_name ExpressionController
extends Node


signal expression_updated(selected_expression_index)
signal selection_updated(selected_expression_index)

const ExpressionIndexer = preload("res://algebra/expression_indexer.gd")
const Rules = preload("res://algebra/logic/rules/rules.gd")

var rules = Rules.rules()
var selected_rule_index: int = 0
var base_expression: AlgebraicExpression
var selected_expression_index := []


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("expression_in"):
		select_inner()
	if Input.is_action_just_pressed("expression_out"):
		select_outer()
	if Input.is_action_just_pressed("expression_left"):
		select_left()
	if Input.is_action_just_pressed("expression_right"):
		select_right()
	if Input.is_action_just_pressed("apply_rule"):
		apply_selected_rule()
	if Input.is_action_just_pressed("cycle_rule"):
		cycle_rule()


func selected_expression() -> AlgebraicExpression:
	return ExpressionIndexer.algebraic_subexpression(
			base_expression, selected_expression_index)


func select_inner() -> void:
	ExpressionIndexer.move_index_in(base_expression, selected_expression_index)
	selection_updated.emit(selected_expression_index)


func select_outer() -> void:
	ExpressionIndexer.move_index_out(selected_expression_index)
	selection_updated.emit(selected_expression_index)


func select_left() -> void:
	ExpressionIndexer.move_index_left(
			base_expression, selected_expression_index)
	selection_updated.emit(selected_expression_index)


func select_right() -> void:
	ExpressionIndexer.move_index_right(
			base_expression, selected_expression_index)
	selection_updated.emit(selected_expression_index)


func apply_rule(rule: AlgebraicRule) -> void:
	if rule.applicable(selected_expression()):
		var new = rule.apply(selected_expression())
		selected_expression().replace(new)
		expression_updated.emit(selected_expression_index)


func apply_selected_rule() -> void:
	apply_rule(rules[selected_rule_index])


func cycle_rule() -> void:
	selected_rule_index = (selected_rule_index + 1) % rules.size()
