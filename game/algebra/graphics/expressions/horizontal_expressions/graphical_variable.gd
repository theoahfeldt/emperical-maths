class_name GraphicalVariable
extends HorizontalExpression


func _get_ordered_components() -> Array[GraphicalComponent]:
	return [_glyphs[0]]


static func create(variable_name: String) -> GraphicalVariable:
	var new := GraphicalVariable.new()
	new._glyphs = [Glyph.create(variable_name)]
	new._add_components_as_children()
	new.set_positions()
	return new
