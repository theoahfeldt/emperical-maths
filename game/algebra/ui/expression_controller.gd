class_name ExpressionController
extends Node2D


signal updated_algebraic()

var _algebraic_rules: Array[AlgebraicRule]
var _algebraic_base: AlgebraicBase
var _graphical_base: GraphicalBase

# The following will be null when not in use:
var _expression_selector: ExpressionSelector
var _abstract_expression_binder: AbstractExpressionBinder
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
		) -> ExpressionController:
	var new := ExpressionController.new()
	new._algebraic_base = AlgebraicBase.create(algebraic_object)
	new._algebraic_rules = algebraic_rules
	return new


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


func _start_abstract_expression_binder(
		abstract_expression: AbstractExpression) -> void:
	var center: Vector2 = get_viewport_rect().size / 2.0
	center.y += 100
	_abstract_expression_binder = AbstractExpressionBinder.create(
			abstract_expression, center)
	add_child(_abstract_expression_binder)
	_abstract_expression_binder.substituted.connect(
			_on_abstract_expression_binder_substituted)


func _replace_subexpression(
		algebraic: AlgebraicExpression, graphical: GraphicalExpression) -> void:
	_algebraic_base.replace_subexpression(algebraic, _current_index)
	ExpressionIndexer.replace_graphical_subexpression(
			_graphical_base, graphical, _current_index)
	updated_algebraic.emit()
	_start_expression_selector()


func _on_expression_selector_selected(
		selected: AlgebraicExpression, index: Array[int]) -> void:
	_current_index = index
	remove_child(_expression_selector)
	_expression_selector.queue_free()
	var menu: SelectionMenu = AlternativeExpressionsMenu.create_from_expression(
			selected, _algebraic_rules)
	_start_alternative_expressions_menu(menu, index)


func _on_alternative_expressions_menu_selected(
		option, graphical: GraphicalExpression) -> void:
	remove_child(_menu_selector)
	_menu_selector.queue_free()
	if option is AlgebraicExpression:
		_replace_subexpression(option, graphical)
	elif option is AbstractExpression:
		ExpressionIndexer.replace_graphical_subexpression(
				_graphical_base, graphical, _current_index)
		_start_abstract_expression_binder(option)
	else:
		push_error("Invalid option: ", option)


func _on_abstract_expression_binder_substituted(
		new_expression: AlgebraicExpression) -> void:
	remove_child(_abstract_expression_binder)
	_abstract_expression_binder.queue_free()
	var graphical := new_expression.to_graphical()
	_replace_subexpression(new_expression, graphical)
