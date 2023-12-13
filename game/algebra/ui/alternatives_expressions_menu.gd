class_name AlternativeExpressionsMenu


static func create_from_expression(
		expression: AlgebraicExpression,
		rules: Array[AlgebraicRule],
		) -> SelectionMenu:
	var applicable := rules.filter(
			func(r): return r.applicable(expression))
	var concrete_alternatives: Array[AlgebraicExpression] = []
	var abstract_alternatives: Array[AbstractExpression] = []
	for rule: AlgebraicRule in applicable:
		if rule is ConcreteRule:
			concrete_alternatives.append(rule.apply(expression))
		elif rule is AbstractRule:
			abstract_alternatives.append(rule.apply(expression))
		else:
			push_error("Invalid rule")
	concrete_alternatives = _unique(concrete_alternatives)
	return AlternativeExpressionsMenu.create(
			concrete_alternatives, abstract_alternatives)


static func create(
		algebraic_expressions: Array[AlgebraicExpression],
		substitutions: Array[AbstractExpression] = [],
		) -> SelectionMenu:
	var options: Array = algebraic_expressions + substitutions
	var graphical_options: Array[GraphicalExpression] = []
	for algebraic in algebraic_expressions:
		var graphical := algebraic.to_graphical()
		graphical.set_color_from_algebraic(algebraic)
		graphical_options.append(graphical)
	for substitution in substitutions:
		graphical_options.append(substitution.graphical_expression())
	return SelectionMenu.create(options, graphical_options)


static func _unique(
		expressions: Array[AlgebraicExpression]) -> Array[AlgebraicExpression]:
	var unique: Array[AlgebraicExpression] = []
	for expression in expressions:
		if not unique.any(expression.identical_to):
			unique.append(expression)
	return unique
