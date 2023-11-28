class_name SelectionMenu
extends GraphicalExpressionOrMenu


const vertical_spacing: int = 100

var options: Array[GraphicalExpression]
var marked_index: int = 0


func get_width() -> int:
	return options.map(func(e): return e.get_width()).max()


func get_height() -> int:
	return options[0].get_height()


static func create(p_options: Array[GraphicalExpression]) -> SelectionMenu:
	if p_options.is_empty():
		push_error("Created empty menu.")
	var menu = SelectionMenu.new()
	menu.options = p_options
	menu.options.map(menu.add_child)
	menu._set_option_positions()
	return menu


func num_options() -> int:
	return options.size()


func marked_option() -> GraphicalExpression:
	return options[marked_index]


func move_up() -> void:
	marked_index = max(0, marked_index - 1)
	_update_marked()


func move_down() -> void:
	marked_index = min(marked_index + 1, num_options() - 1)
	_update_marked()


func _update_marked() -> void:
	_set_opacities()
	var new_position := Vector2(position.x, -vertical_spacing * marked_index)
	move_smooth_to(new_position)


func _set_opacities() -> void:
	for i in range(options.size()):
		var alpha: float = 0.5 ** abs(marked_index - i)
		options[i].set_opacity(alpha)


func _set_option_positions() -> void:
	var width := get_width()
	options.reduce(
			func(y, e): e.position = Vector2((width - e.get_width()) / 2.0, y); return y + vertical_spacing, 0)
