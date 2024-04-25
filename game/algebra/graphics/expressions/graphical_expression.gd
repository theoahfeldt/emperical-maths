class_name GraphicalExpression
extends GraphicalExpressionOrMenu


var subexpressions: Array[GraphicalExpressionOrMenu] = []
@warning_ignore("unused_private_class_variable")
var _glyphs: Array[Glyph] = []


func set_color(color: Color) -> void:
	_get_components().map(func(c): c.set_color(color))


func set_opacity(alpha: float) -> void:
	_get_components().map(func(c): c.set_opacity(alpha))


func set_positions() -> void:
	push_error("Not implemented")


func set_positions_smooth() -> void:
	push_error("Not implemented")


func set_color_from_expression(expression: ManipulableExpression) -> void:
	set_color(expression.color)
	var algebraic: Array[AlgebraicExpression] = expression.subexpressions()
	if algebraic.size() != subexpressions.size():
		push_error("Algebraic expression has different structure")
	for i in range(subexpressions.size()):
		subexpressions[i].set_color_from_expression(algebraic[i])


func replace_subexpression(new: GraphicalExpressionOrMenu, index: int) -> void:
	add_child(new)
	var old := subexpressions[index]
	new.position = Vector2(
			old.position.x + (old.get_width() - new.get_width()) / 2.0,
			old.position.y
			)
	subexpressions[index] = new
	set_positions_smooth()
	remove_child(old)
	old.queue_free()


func _get_components() -> Array[GraphicalComponent]:
	var a: Array[GraphicalComponent] = []
	a.assign(subexpressions)
	var b: Array[GraphicalComponent] = []
	b.assign(_glyphs)
	return a + b


func _add_components_as_children() -> void:
	_get_components().map(func(e): add_child(e))
