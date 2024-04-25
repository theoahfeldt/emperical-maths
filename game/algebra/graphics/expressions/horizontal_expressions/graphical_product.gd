class_name GraphicalProduct
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
		left_factor: GraphicalExpressionOrMenu,
		right_factor: GraphicalExpressionOrMenu,
		) -> GraphicalProduct:
	var new := GraphicalProduct.new()
	new._glyphs = [Glyph.create("("), Glyph.create("·"), Glyph.create(")")]
	new.subexpressions = [left_factor, right_factor]
	new._add_components_as_children()
	new.set_positions()
	return new
