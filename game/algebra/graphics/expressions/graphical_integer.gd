class_name GraphicalInteger
extends GraphicalExpression


func _get_components() -> Array[GraphicalComponent]:
	return [_glyphs[0]]


static func create(value: int) -> GraphicalInteger:
	var new := GraphicalInteger.new()
	new._glyphs = [Glyph.create(str(value))]
	new._add_components_as_children()
	new.set_component_positions()
	return new
