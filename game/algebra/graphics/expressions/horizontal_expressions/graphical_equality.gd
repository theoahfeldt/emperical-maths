class_name GraphicalEquality
extends HorizontalExpression


func _get_ordered_components() -> Array[GraphicalComponent]:
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
	new._glyphs = [Glyph.create("=")]
	new.subexpressions = [left_expression, right_expression]
	new._add_components_as_children()
	new.set_positions()
	return new
