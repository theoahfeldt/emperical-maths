class_name ExpressionController
extends Node2D



var _algebraic_rules: Array[AlgebraicRule]
var _substitution_rules: Array[SubstitutionRule]
var _algebraic_base: AlgebraicBase
var _graphical_base: GraphicalBase

# The following will be null when not in use:
var _expression_selector: ExpressionSelector
var _substitution_selector: SubstitutionSelector
var _menu: SelectionMenu
var _menu_selector: MenuSelector
var _current_index: Array[int] = [0]


func _ready() -> void:
	_graphical_base = GraphicalBase.create(
		_algebraic_base.to_graphical(), get_viewport_rect().size / 2.0)
	add_child(_graphical_base)
	_graphical_base.center()
	_start_expression_selector()


static func create(
		algebraic_object: AlgebraicObject,
		algebraic_rules: Array[AlgebraicRule],
		substitution_rules: Array[SubstitutionRule],
		) -> ExpressionController:
	var new := ExpressionController.new()
	new.initialize(algebraic_object, algebraic_rules, substitution_rules)
	return new


func initialize(
		algebraic_object: AlgebraicObject,
		algeraic_rules: Array[AlgebraicRule],
		substitution_rules: Array[SubstitutionRule],
		) -> void:
	_algebraic_base = AlgebraicBase.create(algebraic_object)
	_algebraic_rules = algeraic_rules
	_substitution_rules = substitution_rules


func _start_expression_selector() -> void:
	_expression_selector = ExpressionSelector.create(
			_algebraic_base, _graphical_base, _current_index)
	add_child(_expression_selector)
	_expression_selector.update_marked()
	_expression_selector.selected.connect(_on_expression_selector_selected)


func _start_alternative_expressions_menu(
		menu: SelectionMenu, index: Array[int]) -> void:
	_menu = menu
	_menu_selector = MenuSelector.create(_menu)
	add_child(_menu_selector)
	_menu_selector.selected.connect(_on_alternative_expressions_menu_selected)
	ExpressionIndexer.replace_graphical_subexpression(
			_graphical_base, _menu, index)


func _start_substitution_selector(substitution: Substitution) -> void:
	var center: Vector2 = get_viewport_rect().size / 2.0
	center.y += 100
	_substitution_selector = SubstitutionSelector.create(substitution, center)
	add_child(_substitution_selector)
	_substitution_selector.substituted.connect(
			_on_substitution_selector_substituted)


func _replace_subexpression(
		algebraic: AlgebraicExpression, graphical: GraphicalExpression) -> void:
	_algebraic_base.replace_subexpression(algebraic, _current_index)
	ExpressionIndexer.replace_graphical_subexpression(
			_graphical_base, graphical, _current_index)
	_start_expression_selector()


func _on_expression_selector_selected(
		selected: AlgebraicExpression, index: Array[int]) -> void:
	_current_index = index
	remove_child(_expression_selector)
	_expression_selector.queue_free()
	var menu: SelectionMenu = AlternativeExpressionsMenu.create_from_expression(
			selected, _algebraic_rules, _substitution_rules)
	_start_alternative_expressions_menu(menu, index)


func _on_alternative_expressions_menu_selected(
		option, graphical: GraphicalExpression) -> void:
	remove_child(_menu_selector)
	_menu_selector.queue_free()
	if option is AlgebraicExpression:
		_replace_subexpression(option, graphical)
	elif option is Substitution:
		ExpressionIndexer.replace_graphical_subexpression(
				_graphical_base, graphical, _current_index)
		_start_substitution_selector(option)
	else:
		push_error("Invalid option: ", option)


func _on_substitution_selector_substituted(
		new_expression: AlgebraicExpression) -> void:
	remove_child(_substitution_selector)
	_substitution_selector.queue_free()
	var graphical := new_expression.to_graphical()
	_replace_subexpression(new_expression, graphical)
