class_name GraphicalEquality
extends GraphicalExpression


func _get_components() -> Array[GraphicalComponent]:
	return [
		subexpressions[0],
		_glyphs[0],
		subexpressions[1],
	]


static func create(
		left_expression: GraphicalExpressionOrMenu,
		right_expression: GraphicalExpressionOrMenu,
		) -> GraphicalEquality:
	var new := GraphicalEquality.new()
	var equality_sign := Glyph.create("=")
	new._glyphs = [equality_sign]
	new.subexpressions = [left_expression, right_expression]
	new._add_components_as_children()
	new.set_component_positions()
	return new
