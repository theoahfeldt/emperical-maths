class_name AlgebraicVariable
extends AlgebraicExpression


var variable_name: String


func _to_string() -> String:
	return variable_name


static func create(
		p_name: String, p_color: Color = default_color) -> AlgebraicVariable:
	var new = AlgebraicVariable.new()
	new.variable_name = p_name
	new.color = p_color
	return new


func copy() -> AlgebraicVariable:
	return AlgebraicVariable.create(variable_name, color)


func subexpressions() -> Array[AlgebraicExpression]:
	return []


func to_graphical() -> GraphicalVariable:
	return GraphicalVariable.create(variable_name)


func mark() -> void:
	color = _sub_colors[0]


func identical_to(other: ManipulableExpression) -> bool:
	if other is AlgebraicVariable:
		return variable_name == other.variable_name
	return false


func pattern_match(expression: ManipulableExpression) -> PatternMatchResult:
	if expression is AlgebraicExpression:
		return PatternMatchSuccess.create({variable_name: expression})
	return PatternMatchFailure.new()


func substitute(
		substitution: Dictionary, replace_unspecified_variables: bool = false
		) -> AlgebraicExpression:
	if variable_name in substitution:
		return substitution[variable_name].copy()
	if replace_unspecified_variables:
		return AlgebraicVariable.create("?")
	return copy()
