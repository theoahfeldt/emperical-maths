class_name ExpressionsMenu
extends GraphicalExpression


const GraphicalConversion = preload("res://algebra/graphics/graphical_conversion.gd")
const vertical_spacing: int = 100

var graphical_expressions: Array
var algebraic_expressions: Array


func get_width() -> int:
	return graphical_expressions.map(func(e): return e.get_width()).max()


func set_color(color: Color) -> void:
	graphical_expressions.map(func(e): e.set_color(color))


static func from_expression(
		expression: AlgebraicExpression, rules: Array) -> ExpressionsMenu:
	var applicable: Array = rules.filter(
			func(r): return r.applicable(expression))
	var alternative_expressions: Array = applicable.map(
			func(r): return r.apply(expression))
	return ExpressionsMenu.from_expressions(alternative_expressions)


static func from_expressions(expressions: Array) -> ExpressionsMenu:
	if expressions.is_empty():
		push_error("Created empty menu.")
	var menu = new()
	menu.algebraic_expressions = expressions
	menu.graphical_expressions = expressions.map(
			GraphicalConversion.algebraic_to_graphical)
	menu.algebraic_expressions.map(menu.add_child)
	menu.graphical_expressions.map(menu.add_child)
	menu.set_expression_positions()
	return menu


func set_expression_positions() -> void:
	graphical_expressions.reduce(
			func(y, e): e.position = Vector2(0, y); return y + vertical_spacing, 0)
