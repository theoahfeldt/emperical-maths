class_name GraphicalSum
extends GraphicalExpression


var left_term: GraphicalExpression
var right_term: GraphicalExpression


func _ready() -> void:
	set_term_positions()


func get_width() -> int:
	var width = 0
	for component in _get_components():
		width += component.get_width()
	return width


func set_color(color: Color) -> void:
	for component in _get_components():
		component.set_color(color)


func set_color_by_depth(depth: int) -> void:
	for component in _get_components():
		component.set_color_by_depth(depth + 1)


func set_term_positions() -> void:
	var width = 0
	for component in _get_components():
		component.position = Vector2(width, 0)
		width += component.get_width()


func _get_components() -> Array:
	return [
		$LeftParenthesis,
		left_term,
		$Sign,
		right_term,
		$RightParenthesis,
	]
