extends Node2D


enum Action {SELECT_EXPRESSION, SELECT_ALTERNATIVE, SELECT_SUBSTITUTION}

const AlgebraicRules := preload("res://algebra/logic/rules/algebraic_rules.gd")
const SubstitutionRules := preload("res://algebra/logic/rules/substitution_rules.gd")

@export var algebraic_base: AlgebraicBase

var algebraic_rules := AlgebraicRules.rules()
var substitution_rules := SubstitutionRules.rules()
var current_action := Action.SELECT_EXPRESSION


func _ready() -> void:
	var graphical := algebraic_base.to_graphical()
	$GraphicalBase.initialize(graphical, get_viewport_rect().size / 2.0)
	$GraphicalBase.center_in_viewport()
	$ExpressionSelector.initialize(algebraic_base, $GraphicalBase)
	$ExpressionSelector.update_marked()


func _process(_delta: float) -> void:
	match current_action:
		Action.SELECT_EXPRESSION:
			$ExpressionSelector.process_input()
		Action.SELECT_ALTERNATIVE:
			$AlternativesMenuSelector.process_input()
		Action.SELECT_SUBSTITUTION:
			$SubstitutionSelector.process_input()


func _select_expression(selected: AlgebraicExpression, mark: Array[int]) -> void:
	var menu: SelectionMenu = $AlternativesMenuSelector.initialize_from_expression(
			mark, selected, algebraic_rules, substitution_rules)
	ExpressionIndexer.replace_graphical_subexpression(
			$GraphicalBase, menu, mark)
	current_action = Action.SELECT_ALTERNATIVE


func _on_expression_selector_selected(selected_expression, mark) -> void:
	_select_expression(selected_expression, mark)


func _on_alternatives_menu_selector_selected_expression(
		algebraic, graphical, mark) -> void:
	algebraic_base.replace_subexpression(algebraic, mark)
	ExpressionIndexer.replace_graphical_subexpression(
			$GraphicalBase, graphical, mark)
	current_action = Action.SELECT_EXPRESSION


func _on_alternatives_menu_selector_selected_substitution(
		substitution, graphical, mark) -> void:
	ExpressionIndexer.replace_graphical_subexpression(
			$GraphicalBase, graphical, mark)
	var center_position: Vector2 = get_viewport_rect().size / 2.0
	center_position.y += 100
	$SubstitutionSelector.initialize(substitution, center_position, mark)
	current_action = Action.SELECT_SUBSTITUTION


func _on_substitution_selector_substituted(
		new_expression: AlgebraicExpression, mark) -> void:
	var graphical := GraphicalConversion.algebraic_to_graphical(new_expression)
	algebraic_base.replace_subexpression(new_expression, mark)
	ExpressionIndexer.replace_graphical_subexpression(
			$GraphicalBase, graphical, mark)
	$ExpressionSelector.update_marked()
	current_action = Action.SELECT_EXPRESSION
