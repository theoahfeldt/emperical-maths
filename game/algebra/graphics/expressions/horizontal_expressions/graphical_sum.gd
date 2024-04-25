class_name GraphicalSum
extends HorizontalExpression


func _get_ordered_components() -> Array[GraphicalComponent]:
	return [
		_glyphs[0],
		subexpressions[0],
		_glyphs[1],
		subexpressions[1],
		_glyphs[2],
	]


static func create(
		left_term: GraphicalExpressionOrMenu,
		right_term: GraphicalExpressionOrMenu,
		) -> GraphicalSum:
	var new := GraphicalSum.new()
	new._glyphs = [Glyph.create("("), Glyph.create("+"), Glyph.create(")")]
	new.subexpressions = [left_term, right_term]
	new._add_components_as_children()
	new.set_positions()
	return new
