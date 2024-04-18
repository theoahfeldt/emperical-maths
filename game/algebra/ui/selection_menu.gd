class_name SelectionMenu
extends GraphicalExpressionOrMenu


const vertical_spacing: int = 100

var _options: Array
var _graphical_options: Array[GraphicalExpression]
var _marked_index: int = 0


func get_width() -> int:
	return _graphical_options.map(func(e): return e.get_width()).max()


func get_height() -> int:
	return _graphical_options[0].get_height()


static func create(
		options: Array, graphical_options: Array[GraphicalExpression]
		) -> SelectionMenu:
	if options.is_empty():
		push_error("Created empty menu")
	if options.size() != graphical_options.size():
		push_error("Must have the same number of options as graphical_options")
	var menu = SelectionMenu.new()
	menu._options = options
	options.map(func(o): if o is Node: menu.add_child(o))
	menu._graphical_options = graphical_options
	graphical_options.map(menu.add_child)
	menu._set_option_positions()
	return menu


static func create_from_rule_applications(
		expression: ManipulableExpression,
		rules: Array[ManipulationRule],
		) -> SelectionMenu:
	var alternatives: Array[ManipulableExpression] = [expression]
	for rule in rules:
		var result := rule.apply(expression)
		if result is ApplicationSuccess:
			alternatives.append(result.result)
	return SelectionMenu.create_from_expressions(_unique(alternatives))


static func create_from_expressions(
		expressions: Array[ManipulableExpression]) -> SelectionMenu:
	var graphical_expressions: Array[GraphicalExpression] = []
	for expression in expressions:
		var graphical := expression.to_graphical()
		graphical.set_color_from_expression(expression)
		graphical_expressions.append(graphical)
	return SelectionMenu.create(expressions, graphical_expressions)


static func _unique(
		expressions: Array[ManipulableExpression]) -> Array[ManipulableExpression]:
	var unique: Array[ManipulableExpression] = []
	for expression in expressions:
		if not unique.any(expression.identical_to):
			unique.append(expression)
	return unique


func num_options() -> int:
	return _options.size()


func marked_option():
	return _options[_marked_index]


func adopt_marked_option():
	var option = marked_option()
	if option is Node:
		remove_child(option)
	return option


func marked_graphical_option() -> GraphicalExpression:
	return _graphical_options[_marked_index]


func adopt_marked_graphical_option() -> GraphicalExpression:
	var option = marked_graphical_option()
	remove_child(option)
	return option


func move_up() -> void:
	_marked_index = max(0, _marked_index - 1)
	_update_marked()


func move_down() -> void:
	_marked_index = min(_marked_index + 1, num_options() - 1)
	_update_marked()


func _update_marked() -> void:
	_set_opacities()
	var new_position := Vector2(position.x, -vertical_spacing * _marked_index)
	move_smooth_to(new_position)


func _set_opacities() -> void:
	for i in range(_graphical_options.size()):
		var alpha: float = 0.5 ** abs(_marked_index - i)
		_graphical_options[i].set_opacity(alpha)


func _set_option_positions() -> void:
	var width := get_width()
	_graphical_options.reduce(
			func(y, e): e.position = Vector2((width - e.get_width()) / 2.0, y); return y + vertical_spacing, 0)
