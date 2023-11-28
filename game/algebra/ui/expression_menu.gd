class_name ExpressionMenu
extends GraphicalExpressionOrMenu


var selection_menu: SelectionMenu
var algebraic_expressions: Array[AlgebraicExpression]
var substitutions: Array[Substitution]


func get_width() -> int:
	return selection_menu.get_width()


func get_height() -> int:
	return selection_menu.get_height()


static func from_expression(
		expression: AlgebraicExpression,
		algebraic_rules: Array[AlgebraicRule],
		substitution_rules: Array[SubstitutionRule]
		) -> ExpressionMenu:
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
	return ExpressionMenu.from_expressions(unique, subs)


static func from_expressions(
		expressions: Array[AlgebraicExpression],
		p_substitutions: Array[Substitution] = [],
		) -> ExpressionMenu:
	if expressions.is_empty():
		push_error("Created empty menu.")
	var menu = new()
	expressions.map(menu.add_child)
	menu.algebraic_expressions = expressions
	menu.substitutions = p_substitutions
	var graphical_expressions: Array[GraphicalExpression] = []
	for algebraic in expressions:
		var graphical := GraphicalConversion.algebraic_to_graphical(algebraic)
		graphical.set_color_from_algebraic(algebraic)
		graphical_expressions.append(graphical)
	for substitution in p_substitutions:
		graphical_expressions.append(substitution.graphical_expression())
	menu.selection_menu = SelectionMenu.create(graphical_expressions)
	menu.add_child(menu.selection_menu)
	return menu


func num_options() -> int:
	return selection_menu.num_options()


func get_option(index: int): # -> AlgebraicExpression or Substitution
	var num_expressions: int = algebraic_expressions.size()
	if index < num_expressions:
		return algebraic_expressions[index]
	else:
		return substitutions[index - num_expressions]


func update_marked(marked_index: int) -> void:
	selection_menu.update_marked(marked_index)


static func _get_unique(
		expressions: Array[AlgebraicExpression]) -> Array[AlgebraicExpression]:
	var unique: Array[AlgebraicExpression] = []
	for expression in expressions:
		if not unique.any(expression.identical_to):
			unique.append(expression)
		else:
			expression.queue_free()
	return unique
