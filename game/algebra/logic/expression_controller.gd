class_name ExpressionController
extends Node


signal expression_updated

const Rules = preload("res://algebra/logic/rules/rules.gd")

var selected_expression: AlgebraicExpression
var selected_stack := []
var rules = Rules.rules()
var selected_rule_index: int = 0


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


func select(expression: AlgebraicExpression) -> void:
	selected_expression.is_selected = false
	expression.is_selected = true
	selected_expression = expression
	expression_updated.emit()


func select_inner() -> void:
	if selected_expression is AlgebraicSum:
		selected_stack.append(selected_expression)
		select(selected_expression.left_term)


func select_outer() -> void:
	if selected_stack.size() > 0:
		select(selected_stack.pop_back())


func select_left() -> void:
	if selected_stack.size() > 0:
		select(selected_stack.back().left_term)


func select_right() -> void:
	if selected_stack.size() > 0:
		select(selected_stack.back().right_term)


func apply_rule(rule: AlgebraicRule) -> void:
	if rule.applicable(selected_expression):
		var new = rule.apply(selected_expression)
		selected_expression.replace(new)
		expression_updated.emit()


func apply_selected_rule() -> void:
	apply_rule(rules[selected_rule_index])


func cycle_rule() -> void:
	selected_rule_index = (selected_rule_index + 1) % rules.size()
