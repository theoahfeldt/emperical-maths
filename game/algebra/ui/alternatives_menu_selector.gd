class_name AlternativesMenuSelector
extends MenuSelector


signal selected_expression(algebraic, graphical, mark)
signal selected_substitution(substitution, graphical, mark)


var _mark: Array[int]


func _select() -> void:
	var option = _menu.adopt_marked_option()
	var graphical: GraphicalExpression = _menu.adopt_marked_graphical_option()
	if option is AlgebraicExpression:
		_select_expression(option, graphical)
	elif option is Substitution:
		_select_substitution(option, graphical)
	else:
		push_error("Unexpected type of menu option")


func initialize_from_expression(
		mark: Array[int],
		expression: AlgebraicExpression,
		algebraic_rules: Array[AlgebraicRule],
		substitution_rules: Array[SubstitutionRule],
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
	return initialize_from_expressions(mark, unique, subs)


func initialize_from_expressions(
		mark: Array[int],
		expressions: Array[AlgebraicExpression],
		substitutions: Array[Substitution] = [],
		) -> SelectionMenu:
	if expressions.is_empty():
		push_error("Created empty menu.")
	_mark = mark
	var options: Array = expressions + substitutions
	var graphical_options: Array[GraphicalExpression] = []
	for algebraic in expressions:
		var graphical := algebraic.to_graphical()
		graphical.set_color_from_algebraic(algebraic)
		graphical_options.append(graphical)
	for substitution in substitutions:
		graphical_options.append(substitution.graphical_expression())
	_menu = SelectionMenu.create(options, graphical_options)
	return _menu


func _select_expression(
		selected: AlgebraicExpression, graphical: GraphicalExpression) -> void:
	selected.mark()
	graphical.set_color_from_algebraic(selected)
	selected_expression.emit(selected, graphical, _mark)


func _select_substitution(
		selected: Substitution, graphical: GraphicalExpression) -> void:
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
