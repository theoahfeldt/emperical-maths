class_name GraphicalSum
extends GraphicalExpression


var left_term: Component
var right_term: Component


func _ready() -> void:
	set_term_positions()


func get_width() -> int:
	return _get_components().reduce(
			func(w, c): return w + c.get_width(), 0)


func set_color(color: Color) -> void:
	_get_components().map(func(c): c.set_color(color))


func set_color_by_depth(depth: int) -> void:
	_get_components().map(func(c): c.set_color_by_depth(depth + 1))


func set_term_positions() -> void:
	_get_components().reduce(
			func(x, c): c.position = Vector2(x, 0); return x + c.get_width(), 0)


func _get_components() -> Array:
	return [
		$LeftParenthesis,
		left_term,
		$Sign,
		right_term,
		$RightParenthesis,
	]
