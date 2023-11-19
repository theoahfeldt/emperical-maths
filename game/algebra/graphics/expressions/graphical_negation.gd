class_name GraphicalNegation
extends GraphicalExpression


var expression: Component


func _ready() -> void:
	set_components_positions()


func get_width() -> int:
	return _get_components().reduce(
			func(w, c): return w + c.get_width(), 0)


func set_color(color: Color) -> void:
	_get_components().map(func(c): c.set_color(color))


func set_color_by_depth(depth: int) -> void:
	_get_components().map(func(c): c.set_color_by_depth(depth + 1))


func set_components_positions() -> void:
	_get_components().reduce(
			func(x, c): c.position = Vector2(x, 0); return x + c.get_width(), 0)


func _get_components() -> Array:
	return [
		$Sign,
		expression,
	]
