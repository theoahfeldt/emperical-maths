class_name SelectionMenu
extends GraphicalExpressionOrMenu


const vertical_spacing: int = 100

var _options: Array
var _graphics: SelectionMenuGraphics
var _marked_index: int = 0


func get_width() -> float:
	return _graphics.get_width()


func get_height() -> float:
	return _graphics.get_height()


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
	menu._graphics = SelectionMenuGraphics.create(graphical_options)
	menu.add_child(menu._graphics)
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
	return _graphics.options[_marked_index]


func adopt_marked_graphical_option() -> GraphicalExpression:
	var option = marked_graphical_option()
	_graphics.remove_child(option)
	return option


func move_up() -> void:
	_marked_index = max(0, _marked_index - 1)
	_update_marked()


func move_down() -> void:
	_marked_index = min(_marked_index + 1, num_options() - 1)
	_update_marked()


func _update_marked() -> void:
	_set_opacities()
	var new_position := Vector2(0, -vertical_spacing * _marked_index)
	_graphics.move_smooth_to(new_position)


func _set_opacities() -> void:
	_graphics.set_opacities(_marked_index)
