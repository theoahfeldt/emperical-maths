class_name SelectionMenuGraphics
extends GraphicalComponent


const vertical_spacing: int = 100

var options: Array[GraphicalExpression]


func get_width() -> float:
	return options.map(func(e): return e.get_width()).max()


func get_height() -> float:
	return options.map(func(e): return e.get_height()).max()


static func create(
		p_options: Array[GraphicalExpression]) -> SelectionMenuGraphics:
	var graphics = SelectionMenuGraphics.new()
	graphics.options = p_options
	p_options.map(graphics.add_child)
	graphics._set_option_positions()
	return graphics


func set_opacities(marked_index) -> void:
	for i in range(options.size()):
		var alpha: float = 0.5 ** abs(marked_index - i)
		options[i].set_opacity(alpha)


func _set_option_positions() -> void:
	var width := get_width()
	options.reduce(
			func(y, e): e.position = Vector2((width - e.get_width()) / 2.0, y); return y + vertical_spacing, 0)
