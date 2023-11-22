class_name SelectionMenu
extends GraphicalComponent


const vertical_spacing: int = 100

var options: Array[GraphicalExpression]
var _marked_index: int = 0


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


func update_marked(marked_index: int) -> void:
	_marked_index = marked_index
	_set_opacities()
	var new_position := Vector2(position.x, -vertical_spacing * _marked_index)
	move_smooth_to(new_position)


func _set_opacities() -> void:
	for i in range(options.size()):
		var alpha: float = 0.5 ** (abs(_marked_index - i) - 0.5)
		options[i].set_opacity(alpha)


func _set_option_positions() -> void:
	var width := get_width()
	options.reduce(
			func(y, e): e.position = Vector2((width - e.get_width()) / 2.0, y); return y + vertical_spacing, 0)
