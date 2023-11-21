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
			algebraic_base.expression)
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


func _select_expression(mark: Array[int]) -> void:
	var selected := ExpressionIndexer.algebraic_subexpression(
			algebraic_base, mark)
	var menu := ExpressionMenu.from_expression(selected, rules)
	ExpressionIndexer.replace_graphical_subexpression(
			$GraphicalBase, menu, mark)
	$ExpressionsMenuSelector.initialize(menu, mark)
	expression_is_selected = true


func _replace_subexpression(
		algebraic: AlgebraicExpression, graphical: GraphicalExpression, mark
		) -> void:
	ExpressionIndexer.replace_algebraic_subexpression(
			algebraic_base, algebraic, mark)
	ExpressionIndexer.replace_graphical_subexpression(
			$GraphicalBase, graphical, mark)


func _on_expression_selector_mark_updated(mark) -> void:
	_update_mark(mark)


func _on_expression_selector_selected(mark) -> void:
	_select_expression(mark)


func _on_expressions_menu_selector_selected(algebraic, graphical, mark) -> void:
	_replace_subexpression(algebraic, graphical, mark)
	_update_mark(mark)
	expression_is_selected = false
