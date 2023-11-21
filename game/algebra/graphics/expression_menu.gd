class_name ExpressionMenu
extends GraphicalExpressionOrMenu


const GraphicalConversion = preload("res://algebra/graphics/graphical_conversion.gd")

var selection_menu: SelectionMenu
var algebraic_expressions: Array[AlgebraicExpression]


func get_width() -> int:
	return selection_menu.get_width()


func get_height() -> int:
	return selection_menu.get_height()


func set_color(color: Color) -> void:
	selection_menu.set_color(color)


static func from_expression(
		expression: AlgebraicExpression, rules: Array[AlgebraicRule]
		) -> ExpressionMenu:
	var applicable := rules.filter(func(r): return r.applicable(expression))
	@warning_ignore("unassigned_variable")
	var alternative_expressions: Array[AlgebraicExpression]
	alternative_expressions.assign(
			applicable.map(func(r): return r.apply(expression)))
	var unique := _get_unique(alternative_expressions)
	return ExpressionMenu.from_expressions(unique)


static func from_expressions(expressions: Array[AlgebraicExpression]) -> ExpressionMenu:
	if expressions.is_empty():
		push_error("Created empty menu.")
	var menu = new()
	menu.algebraic_expressions = expressions
	menu.algebraic_expressions.map(menu.add_child)
	@warning_ignore("unassigned_variable")
	var graphical_expressions: Array[GraphicalExpression]
	graphical_expressions.assign(expressions.map(
			GraphicalConversion.algebraic_to_graphical))
	menu.selection_menu = SelectionMenu.create(graphical_expressions)
	menu.add_child(menu.selection_menu)
	return menu


func num_options() -> int:
	return selection_menu.num_options()


func update_marked(marked_index: int) -> void:
	selection_menu.update_marked(marked_index)


static func _get_unique(
		expressions: Array[AlgebraicExpression]) -> Array[AlgebraicExpression]:
	var unique: Array[AlgebraicExpression] = []
	for expression in expressions:
		if not unique.any(expression.identical_to):
			unique.append(expression)
	return unique
