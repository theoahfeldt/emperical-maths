class_name GraphicalSum
extends GraphicalExpression


func _get_components() -> Array[GraphicalComponent]:
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
	var left_parenthesis := Glyph.create("(")
	var plus_sign := Glyph.create("+")
	var right_parenthesis := Glyph.create(")")
	new._glyphs = [
		left_parenthesis,
		plus_sign,
		right_parenthesis,
	]
	new.subexpressions = [left_term, right_term]
	new._add_components_as_children()
	new.set_component_positions()
	return new
