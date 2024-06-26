class_name AlgebraicNegation
extends AlgebraicExpression


var expression: AlgebraicExpression


func _to_string() -> String:
	return "-%s" % expression


static func create(
		a: AlgebraicExpression, p_color: Color = default_color
		) -> AlgebraicNegation:
	var new = AlgebraicNegation.new()
	new.expression = a
	new.color = p_color
	return new


func copy() -> AlgebraicNegation:
	return AlgebraicNegation.create(expression.copy(), color)


func subexpressions() -> Array[AlgebraicExpression]:
	return [expression]


func replace_subexpression(new: AlgebraicExpression, index: int) -> void:
	if index == 0:
		expression = new
	else:
		push_error("Index %d out of range" % index)


func to_graphical() -> GraphicalNegation:
	return GraphicalNegation.create(expression.to_graphical())


func set_color(p_color: Color) -> void:
	color = p_color
	expression.set_color(p_color)


func mark() -> void:
	color = _sub_colors[0]
	expression.set_color(_sub_colors[0])


func identical_to(other: ManipulableExpression) -> bool:
	if other is AlgebraicNegation:
		return expression.identical_to(other.expression)
	return false


func pattern_match(manipulable_expression: ManipulableExpression) -> PatternMatchResult:
	if manipulable_expression is AlgebraicNegation:
		return expression.pattern_match(manipulable_expression.expression)
	else:
		return PatternMatchFailure.new()


func substitute(
		substitution: Dictionary, replace_unspecified_variables: bool = false
		) -> AlgebraicNegation:
	var instance := expression.substitute(
			substitution, replace_unspecified_variables)
	return AlgebraicNegation.create(instance)
