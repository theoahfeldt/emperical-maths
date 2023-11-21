extends Node2D


const ExpressionIndexer := preload("res://algebra/expression_indexer.gd")
const GraphicalConversion := preload("res://algebra/graphics/graphical_conversion.gd")
const Rules := preload("res://algebra/logic/rules/rules.gd")

@export var algebraic_base: AlgebraicBase

var expression_is_selected := false
var rules = Rules.rules()


func _ready() -> void:
	$ExpressionSelector.base = algebraic_base
	var expression := GraphicalConversion.algebraic_to_graphical(
			algebraic_base.expression, rules)
	$GraphicalBase.initialize(expression)
	_update_mark([])


func _process(_delta: float) -> void:
	if expression_is_selected:
		$ExpressionsMenuSelector.process_input()
	else:
		$ExpressionSelector.process_input()


func _update_mark(mark: Array[int]) -> void:
	$GraphicalBase.reset()
	var marked_expression: GraphicalExpression = ExpressionIndexer.graphical_subexpression(
			$GraphicalBase, mark)
	marked_expression.mark()


func _update_graphics() -> void:
	var new := GraphicalConversion.algebraic_to_graphical(
			algebraic_base.expression, rules)
	$GraphicalBase.replace_expression(new)


func _select_expression(mark: Array[int]) -> void:
	var selected_expression: AlgebraicExpression = ExpressionIndexer.algebraic_subexpression(
			algebraic_base, mark)
	selected_expression.is_selected = true
	_update_graphics()
	var menu: ExpressionMenu = ExpressionIndexer.graphical_subexpression(
			$GraphicalBase, mark)
	$ExpressionsMenuSelector.initialize(menu, mark)
	expression_is_selected = true


func _replace_subexpression(mark: Array, new: AlgebraicExpression) -> void:
	ExpressionIndexer.replace_algebraic_subexpression(algebraic_base, new, mark)


func _on_expression_selector_mark_updated(mark) -> void:
	_update_mark(mark)


func _on_expression_selector_selected(mark) -> void:
	_select_expression(mark)


func _on_expressions_menu_selector_selected(expression, mark) -> void:
	_replace_subexpression(mark, expression)
	_update_graphics()
	_update_mark(mark)
	expression_is_selected = false
