class_name AlgebraicVariable
extends AlgebraicExpression


var variable_name: String


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


func pretty_string() -> String:
	return variable_name


func to_graphical() -> GraphicalVariable:
	return GraphicalVariable.create(variable_name)


func mark() -> void:
	color = _sub_colors[0]


func identical_to(other: AlgebraicExpression) -> bool:
	if other is AlgebraicVariable:
		return variable_name == other.variable_name
	return false


func pattern_match(expression: AlgebraicExpression) -> PatternMatchResult:
	return PatternMatchSuccess.create({variable_name: expression})


func bind(bindings: Dictionary) -> AlgebraicExpression:
	if variable_name in bindings:
		return bindings[variable_name]
	return AlgebraicVariable.create("?")
