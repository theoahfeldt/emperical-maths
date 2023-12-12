class_name AlternativeExpressionsMenu


static func create_from_expression(
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
	subs.assign(applicable_substitutions.map(
			func(r): return r.apply(expression)))
	return AlternativeExpressionsMenu.create(unique, subs)


static func create(
		expressions: Array[AlgebraicExpression],
		substitutions: Array[Substitution] = [],
		) -> SelectionMenu:
	if expressions.is_empty():
		push_error("Created empty menu.")
	var options: Array = expressions + substitutions
	var graphical_options: Array[GraphicalExpression] = []
	for algebraic in expressions:
		var graphical := algebraic.to_graphical()
		graphical.set_color_from_algebraic(algebraic)
		graphical_options.append(graphical)
	for substitution in substitutions:
		graphical_options.append(substitution.graphical_expression())
	return SelectionMenu.create(options, graphical_options)


static func _get_unique(
		expressions: Array[AlgebraicExpression]) -> Array[AlgebraicExpression]:
	var unique: Array[AlgebraicExpression] = []
	for expression in expressions:
		if not unique.any(expression.identical_to):
			unique.append(expression)
	return unique
