class_name GraphicalExpression
extends GraphicalExpressionOrMenu


var _components: Array[GraphicalComponent]
var subexpressions: Array[GraphicalExpressionOrMenu] = []


func get_width() -> int:
	return _components.reduce(
			func(w, c): return w + c.get_width(), 0)


func get_height() -> int:
	return _components[0].get_height()


func set_color(color: Color) -> void:
	_components.map(func(c): c.set_color(color))


func set_color_by_depth(depth: int) -> void:
	_components.map(func(c): c.set_color_by_depth(depth + 1))


static func variable(variable_name: String) -> GraphicalExpression:
	var new := GraphicalExpression.new()
	var glyph := Glyph.create(variable_name)
	new._components = [glyph]
	new._add_components_as_children()
	new._set_component_positions()
	return new


static func integer(value: int) -> GraphicalExpression:
	var new := GraphicalExpression.new()
	var glyph := Glyph.create(str(value))
	new._components = [glyph]
	new._add_components_as_children()
	new._set_component_positions()
	return new


static func negation(expression: GraphicalExpressionOrMenu) -> GraphicalExpression:
	var new := GraphicalExpression.new()
	var minus_sign := Glyph.create("-")
	new.subexpressions = [expression]
	new._components = [minus_sign, expression]
	new._add_components_as_children()
	new._set_component_positions()
	return new


static func sum(
		left_term: GraphicalExpressionOrMenu, right_term: GraphicalExpressionOrMenu
		) -> GraphicalExpression:
	var new := GraphicalExpression.new()
	var left_parenthesis := Glyph.create("(")
	var plus_sign := Glyph.create("+")
	var right_parenthesis := Glyph.create(")")
	new.subexpressions = [left_term, right_term]
	new._components = [
		left_parenthesis,
		left_term,
		plus_sign,
		right_term,
		right_parenthesis,
	]
	new._add_components_as_children()
	new._set_component_positions()
	return new


func mark() -> void:
	set_color(marked_color)


func _set_component_positions() -> void:
	_components.reduce(
			func(x, c): c.position = Vector2(x, 0); return x + c.get_width(), 0)


func _add_components_as_children() -> void:
	_components.map(add_child)
