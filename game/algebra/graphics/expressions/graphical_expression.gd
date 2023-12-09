class_name GraphicalExpression
extends GraphicalExpressionOrMenu


@warning_ignore("unused_private_class_variable")
var _glyphs: Array[Glyph] = []
var subexpressions: Array[GraphicalExpressionOrMenu] = []


func get_width() -> int:
	return _get_components().reduce(
			func(w, c): return w + c.get_width(), 0)


func get_height() -> int:
	return _get_components()[0].get_height()


func set_color(color: Color) -> void:
	_get_components().map(func(c): c.set_color(color))


func set_opacity(alpha: float) -> void:
	_get_components().map(func(c): c.set_opacity(alpha))


func _get_components() -> Array[GraphicalComponent]:
	push_error("Function not implemented")
	return []


func set_color_from_algebraic(object: AlgebraicObject) -> void:
	set_color(object.color)
	var algebraic: Array[AlgebraicExpression] = object.subexpressions()
	if algebraic.size() != subexpressions.size():
		push_error("Algebraic object has different structure")
	for i in range(subexpressions.size()):
		subexpressions[i].set_color_from_algebraic(algebraic[i])


func replace_subexpression(new: GraphicalExpressionOrMenu, index: int) -> void:
	add_child(new)
	var old := subexpressions[index]
	new.position = Vector2(old.position.x + (old.get_width() - new.get_width()) / 2.0, 0)
	subexpressions[index] = new
	set_component_positions_smooth()
	remove_child(old)
	old.queue_free()


func set_component_positions() -> void:
	_get_components().reduce(
			func(x, c): c.position = Vector2(x, 0); return x + c.get_width(), 0)


func set_component_positions_smooth() -> void:
	_get_components().reduce(
			func(x, c): c.move_smooth_to(Vector2(x, 0)); return x + c.get_width(), 0)


func _add_components_as_children() -> void:
	_get_components().map(add_child)