class_name HorizontalExpression
extends GraphicalExpression


func _get_ordered_components() -> Array[GraphicalComponent]:
	push_error("Not implemented")
	return []


func get_width() -> float:
	return _get_ordered_components().reduce(
			func(w, c): return w + c.get_width(), 0)


func get_height() -> float:
	if not subexpressions:
		return _glyphs[0].get_height()
	var min_y_: float = subexpressions.map(func(e): return e.min_y()).min()
	var max_y_: float = subexpressions.map(func(e): return e.max_y()).max()
	return max_y_ - min_y_


func set_positions() -> void:
	_get_ordered_components().reduce(
			func(x, c): c.set_position(Vector2(x, 0)); return x + c.get_width(), 0)


func set_positions_smooth() -> void:
	_get_ordered_components().reduce(
			func(x, c): c.move_smooth_to(Vector2(x, 0)); return x + c.get_width(), 0)
