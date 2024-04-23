class_name GraphicalNegation
extends HorizontalExpression


func _get_ordered_components() -> Array[GraphicalComponent]:
	return [_glyphs[0], subexpressions[0]]


static func create(expression: GraphicalExpressionOrMenu) -> GraphicalNegation:
	var new := GraphicalNegation.new()
	var minus_sign := Glyph.create("-")
	new._glyphs = [minus_sign]
	new.subexpressions = [expression]
	new._add_components_as_children()
	new.set_positions()
	return new
