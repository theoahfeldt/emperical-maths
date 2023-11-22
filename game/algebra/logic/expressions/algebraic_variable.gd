class_name AlgebraicVariable
extends AlgebraicExpression


@export var variable_name: String


static func create(
		p_name: String, p_color: Color = default_color) -> AlgebraicVariable:
	var variable = AlgebraicVariable.new()
	variable.variable_name = p_name
	variable.color = p_color
	return variable


func identical_to(other: AlgebraicExpression) -> bool:
	if other is AlgebraicVariable:
		return variable_name == other.variable_name
	return false


func copy() -> AlgebraicExpression:
	return AlgebraicVariable.create(variable_name, color)


func pretty_string() -> String:
	return variable_name


func mark() -> void:
	color = _sub_colors[0]
