extends Node2D


const ExpressionIndexer := preload("res://algebra/expression_indexer.gd")
const GraphicalConversion := preload("res://algebra/graphics/graphical_conversion.gd")
const Rules := preload("res://algebra/logic/rules/rules.gd")

@export var algebraic_expression: AlgebraicExpression

var graphical_expression: GraphicalExpression
var expression_is_selected := false
var rules = Rules.rules()


func _ready() -> void:
	$ExpressionSelector.base_expression = algebraic_expression
	_set_graphics()
	_update_mark([])


func _process(_delta: float) -> void:
	if expression_is_selected:
		$ExpressionsMenuSelector.process_input()
	else:
		$ExpressionSelector.process_input()


func _set_graphics() -> void:
	graphical_expression = GraphicalConversion.algebraic_to_graphical(
			algebraic_expression, rules)
	graphical_expression.initialize()
	add_child(graphical_expression)


func _update_mark(mark: Array) -> void:
	graphical_expression.initialize()
	var marked_expression: GraphicalExpression = ExpressionIndexer.graphical_subexpression(
			graphical_expression, mark)
	marked_expression.mark()


func _update_graphics() -> void:
	graphical_expression.queue_free()
	_set_graphics()


func _select_expression(mark: Array) -> void:
	var selected_expression: AlgebraicExpression = ExpressionIndexer.algebraic_subexpression(
			algebraic_expression, mark)
	selected_expression.is_selected = true
	_update_graphics()
	var menu = ExpressionIndexer.graphical_subexpression(
			graphical_expression, mark)
	$ExpressionsMenuSelector.initialize(menu, mark)
	expression_is_selected = true


func _replace_base_expression(new: AlgebraicExpression) -> void:
	remove_child(algebraic_expression)
	algebraic_expression.queue_free()
	add_child(new)
	algebraic_expression = new
	$ExpressionSelector.base_expression = algebraic_expression


func _replace_subexpression(mark: Array, new: AlgebraicExpression) -> void:
	if mark.is_empty():
		_replace_base_expression(new)
	else:
		ExpressionIndexer.replace_algebraic_subexpression(algebraic_expression, new, mark)


func _on_expression_selector_mark_updated(mark) -> void:
	_update_mark(mark)


func _on_expression_selector_selected(mark) -> void:
	_select_expression(mark)


func _on_expressions_menu_selector_selected(expression, mark) -> void:
	_replace_subexpression(mark, expression)
	_update_graphics()
	_update_mark(mark)
	expression_is_selected = false
