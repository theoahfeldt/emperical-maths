extends Node2D


const CommutativitySum = preload("res://algebra/rules/commutativity_sum.gd")


var selected_stack: Array
@export var selected_expression: AlgebraicExpression


# Add signals for when an expression is selected and deselected
# React to signals in AlgebraicExpression
func select(expression: AlgebraicExpression) -> void:
	selected_expression.deselected()
	selected_expression = expression
	expression.selected()


func select_inner() -> void:
	if selected_expression is Sum:
		selected_stack.append(selected_expression)
		select(selected_expression.a)


func select_outer() -> void:
	if selected_stack.size() > 0:
		select(selected_stack.pop_back())


func select_left() -> void:
	if selected_stack.size() > 0:
		select(selected_stack.back().a)


func select_right() -> void:
	if selected_stack.size() > 0:
		select(selected_stack.back().b)


func apply_rule(rule: AlgebraicRule) -> void:
	if rule.applicable(selected_expression):
		rule.apply(selected_expression)
		selected_expression.update()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
		apply_rule(CommutativitySum.new())
