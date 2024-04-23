class_name GraphicalInteger
extends HorizontalExpression


func _get_ordered_components() -> Array[GraphicalComponent]:
	return [_glyphs[0]]


static func create(value: int) -> GraphicalInteger:
	var new := GraphicalInteger.new()
	new._glyphs = [Glyph.create(str(value))]
	new._add_components_as_children()
	new.set_positions()
	return new
