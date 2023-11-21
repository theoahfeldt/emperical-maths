class_name ExpressionMenu
extends GraphicalExpressionOrMenu


const GraphicalConversion = preload("res://algebra/graphics/graphical_conversion.gd")
const vertical_spacing: int = 100
const movement_duration: float = 0.05

var graphical_expressions: Array[GraphicalExpression]
var algebraic_expressions: Array[AlgebraicExpression]
var _movement: Movement


func _process(delta: float) -> void:
	if _movement != null and _movement.has_update(delta):
		position = _movement.current_position()


func get_width() -> int:
	return graphical_expressions.map(func(e): return e.get_width()).max()


func get_height() -> int:
	return graphical_expressions[0].get_height()


func set_color(color: Color) -> void:
	graphical_expressions.map(func(e): e.set_color(color))


static func from_expression(
		expression: AlgebraicExpression, rules: Array[AlgebraicRule]
		) -> ExpressionMenu:
	var applicable := rules.filter(func(r): return r.applicable(expression))
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
	menu.graphical_expressions.assign(expressions.map(
			GraphicalConversion.algebraic_to_graphical))
	menu.algebraic_expressions.map(menu.add_child)
	menu.graphical_expressions.map(menu.add_child)
	menu._set_expression_positions()
	return menu


func _set_expression_positions() -> void:
	graphical_expressions.reduce(
			func(y, e): e.position = Vector2(0, y); return y + vertical_spacing, 0)


func set_position_by_marked(marked_index: int = 0) -> void:
	var new_position := Vector2(position.x, -vertical_spacing * marked_index)
	_movement = Movement.create(position, new_position, movement_duration)


static func _get_unique(
		expressions: Array[AlgebraicExpression]) -> Array[AlgebraicExpression]:
	var unique: Array[AlgebraicExpression] = []
	for expression in expressions:
		if not unique.any(expression.identical_to):
			unique.append(expression)
	return unique
