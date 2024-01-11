class_name AlgebraicNegation
extends AlgebraicExpression


var expression: AlgebraicExpression


static func create(
		a: AlgebraicExpression, p_color: Color = default_color
		) -> AlgebraicNegation:
	var new = AlgebraicNegation.new()
	new.expression = a
	new.color = p_color
	return new


func identical_to(other: AlgebraicExpression) -> bool:
	if other is AlgebraicNegation:
		return expression.identical_to(other.expression)
	return false


func copy() -> AlgebraicNegation:
	return AlgebraicNegation.create(expression.copy(), color)


func subexpressions() -> Array[AlgebraicExpression]:
	return [expression]


func replace_subexpression(new: AlgebraicExpression, index: int) -> void:
	if index == 0:
		expression = new
	else:
		push_error("Index %d out of range" % index)


func pretty_string() -> String:
	return "-%s" % expression.pretty_string()


func to_graphical() -> GraphicalNegation:
	return GraphicalNegation.create(expression.to_graphical())


func pattern_match(object: AlgebraicObject) -> PatternMatchResult:
	if object is AlgebraicNegation:
		return expression.pattern_match(object.expression)
	else:
		return PatternMatchResult.no_match()


func set_color(p_color: Color) -> void:
	color = p_color
	expression.set_color(p_color)


func mark() -> void:
	color = _sub_colors[0]
	expression.set_color(_sub_colors[0])
