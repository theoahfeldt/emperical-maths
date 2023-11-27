extends Node2D


enum Actions {SELECT_EXPRESSION, SELECT_ALTERNATIVE, SELECT_SUBSTITUTION}

const AlgebraicRules := preload("res://algebra/logic/rules/algebraic_rules.gd")
const SubstitutionRules := preload("res://algebra/logic/rules/substitution_rules.gd")

@export var algebraic_base: AlgebraicBase

var algebraic_rules := AlgebraicRules.rules()
var substitution_rules := SubstitutionRules.rules()
var current_action := Actions.SELECT_EXPRESSION


func _ready() -> void:
	$ExpressionSelector.base = algebraic_base
	var expression := GraphicalConversion.algebraic_to_graphical(
			algebraic_base.expression)
	$GraphicalBase.initialize(expression)
	$GraphicalBase.center_in_viewport()
	$ExpressionSelector.update_marked()


func _process(_delta: float) -> void:
	match current_action:
		Actions.SELECT_EXPRESSION:
			$ExpressionSelector.process_input()
		Actions.SELECT_ALTERNATIVE:
			$ExpressionsMenuSelector.process_input()
		Actions.SELECT_SUBSTITUTION:
			$SubstitutionSelector.process_input()


func _update_mark(marked: AlgebraicExpression, mark: Array[int]) -> void:
	$GraphicalBase.clear_color()
	var graphical: GraphicalExpression = ExpressionIndexer.graphical_subexpression(
			$GraphicalBase, mark)
	marked.mark()
	graphical.set_color_from_algebraic(marked)


func _select_expression(selected: AlgebraicExpression, mark: Array[int]) -> void:
	var menu := ExpressionMenu.from_expression(
			selected, algebraic_rules, substitution_rules)
	ExpressionIndexer.replace_graphical_subexpression(
			$GraphicalBase, menu, mark)
	$ExpressionsMenuSelector.initialize(menu, mark)
	current_action = Actions.SELECT_ALTERNATIVE


func _replace_subexpression(
		algebraic: AlgebraicExpression, graphical: GraphicalExpression, mark
		) -> void:
	ExpressionIndexer.replace_algebraic_subexpression(
			algebraic_base, algebraic, mark)
	ExpressionIndexer.replace_graphical_subexpression(
			$GraphicalBase, graphical, mark)


func _on_expression_selector_mark_updated(marked_expression, mark) -> void:
	_update_mark(marked_expression, mark)


func _on_expression_selector_selected(selected_expression, mark) -> void:
	_select_expression(selected_expression, mark)


func _on_expressions_menu_selector_selected_expression(
		algebraic, graphical, mark) -> void:
	_replace_subexpression(algebraic, graphical, mark)
	_update_mark(algebraic, mark)
	current_action = Actions.SELECT_EXPRESSION


func _on_expressions_menu_selector_selected_substitution(
		substitution, graphical, mark) -> void:
	ExpressionIndexer.replace_graphical_subexpression(
			$GraphicalBase, graphical, mark)
	$SubstitutionSelector.initialize(algebraic_base.copy(), substitution, mark)
	current_action = Actions.SELECT_SUBSTITUTION


func _on_substitution_selector_substituted(new_expression, mark) -> void:
	ExpressionIndexer.replace_algebraic_subexpression(
			algebraic_base, new_expression, mark)
	var graphical := GraphicalConversion.algebraic_to_graphical(new_expression)
	ExpressionIndexer.replace_graphical_subexpression(
			$GraphicalBase, graphical, mark)
	_update_mark(new_expression, mark)
	$SubstitutionSelector.deinitialize()
	current_action = Actions.SELECT_EXPRESSION
