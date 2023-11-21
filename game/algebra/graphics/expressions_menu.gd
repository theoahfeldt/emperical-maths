class_name ExpressionsMenu
extends GraphicalExpressionOrMenu


const GraphicalConversion = preload("res://algebra/graphics/graphical_conversion.gd")
const vertical_spacing: int = 100

var graphical_expressions: Array[GraphicalExpression]
var algebraic_expressions: Array[AlgebraicExpression]


func get_width() -> int:
	return graphical_expressions.map(func(e): return e.get_width()).max()


func get_height() -> int:
	return graphical_expressions[0].get_height()


func set_color(color: Color) -> void:
	graphical_expressions.map(func(e): e.set_color(color))


static func from_expression(
		expression: AlgebraicExpression, rules: Array[AlgebraicRule]
		) -> ExpressionsMenu:
	var applicable := rules.filter(func(r): return r.applicable(expression))
	var alternative_expressions: Array[AlgebraicExpression]
	alternative_expressions.assign(
			applicable.map(func(r): return r.apply(expression)))
	var unique := _get_unique(alternative_expressions)
	return ExpressionsMenu.from_expressions(unique)


static func from_expressions(expressions: Array[AlgebraicExpression]) -> ExpressionsMenu:
	if expressions.is_empty():
		push_error("Created empty menu.")
	var menu = new()
	menu.algebraic_expressions = expressions
	menu.graphical_expressions.assign(expressions.map(
			GraphicalConversion.algebraic_to_graphical))
	menu.algebraic_expressions.map(menu.add_child)
	menu.graphical_expressions.map(menu.add_child)
	menu.set_expression_positions()
	return menu


func set_expression_positions() -> void:
	graphical_expressions.reduce(
			func(y, e): e.position = Vector2(0, y); return y + vertical_spacing, 0)


static func _get_unique(
		expressions: Array[AlgebraicExpression]) -> Array[AlgebraicExpression]:
	var unique: Array[AlgebraicExpression] = []
	for expression in expressions:
		if not unique.any(expression.identical_to):
			unique.append(expression)
	return unique
