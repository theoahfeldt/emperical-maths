class_name ExpressionMenuSelector
extends Node


signal selected_expression(algebraic, graphical, mark)
signal selected_substitution(substitution, graphical, mark)


var _algebraic_expressions: Array[AlgebraicExpression]
var _substitutions: Array[Substitution]
var _menu: SelectionMenu
var _mark: Array[int]


func initialize_from_expression(
		expression: AlgebraicExpression,
		algebraic_rules: Array[AlgebraicRule],
		substitution_rules: Array[SubstitutionRule],
		mark: Array[int],
		) -> SelectionMenu:
	var applicable_algebraic := algebraic_rules.filter(
			func(r): return r.applicable(expression))
	@warning_ignore("unassigned_variable")
	var alternative_expressions: Array[AlgebraicExpression]
	alternative_expressions.assign(
			applicable_algebraic.map(func(r): return r.apply(expression)))
	var unique := _get_unique(alternative_expressions)
	var applicable_substitutions := substitution_rules.filter(
			func(r): return r.applicable(expression))
	@warning_ignore("unassigned_variable")
	var subs: Array[Substitution]
	subs.assign(
			applicable_substitutions.map(func(r): return r.apply(expression)))
	return initialize_from_expressions(unique, subs, mark)


func initialize_from_expressions(
		expressions: Array[AlgebraicExpression],
		p_substitutions: Array[Substitution],
		mark: Array[int],
		) -> SelectionMenu:
	if expressions.is_empty():
		push_error("Created empty menu.")
	_mark = mark
	expressions.map(add_child)
	_algebraic_expressions = expressions
	_substitutions = p_substitutions
	var graphical_expressions: Array[GraphicalExpression] = []
	for algebraic in expressions:
		var graphical := GraphicalConversion.algebraic_to_graphical(algebraic)
		graphical.set_color_from_algebraic(algebraic)
		graphical_expressions.append(graphical)
	for substitution in p_substitutions:
		graphical_expressions.append(substitution.graphical_expression())
	_menu = SelectionMenu.create(graphical_expressions)
	return _menu


func process_input() -> void:
	if Input.is_action_just_pressed("expression_up"):
		_menu.move_up()
	if Input.is_action_just_pressed("expression_down"):
		_menu.move_down()
	if Input.is_action_just_pressed("expression_select"):
		_select_option()


func _select_option() -> void:
	var num_expressions: int = _algebraic_expressions.size()
	var i: int = _menu.marked_index
	if i < num_expressions:
		_select_expression(_algebraic_expressions[i])
	else:
		_select_substitution(_substitutions[i - num_expressions])


func _select_expression(selected: AlgebraicExpression) -> void:
	remove_child(selected)
	var graphical: GraphicalExpression = _menu.marked_option()
	_menu.remove_child(graphical)
	selected.mark()
	graphical.set_color_from_algebraic(selected)
	selected_expression.emit(selected, graphical, _mark)


func _select_substitution(selected: Substitution) -> void:
	var graphical: GraphicalExpression = _menu.marked_option()
	_menu.remove_child(graphical)
	selected_substitution.emit(selected, graphical, _mark)


func _get_unique(
		expressions: Array[AlgebraicExpression]) -> Array[AlgebraicExpression]:
	var unique: Array[AlgebraicExpression] = []
	for expression in expressions:
		if not unique.any(expression.identical_to):
			unique.append(expression)
		else:
			expression.queue_free()
	return unique
