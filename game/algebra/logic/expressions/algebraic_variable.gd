class_name AlgebraicVariable
extends AlgebraicExpression


@export var variable_name: String


static func create(p_name: String) -> AlgebraicVariable:
	var variable = AlgebraicVariable.new()
	variable.variable_name = p_name
	return variable


func identical_to(other: AlgebraicExpression) -> bool:
	if other is AlgebraicVariable:
		return variable_name == other.variable_name
	return false


func copy() -> AlgebraicExpression:
	var new = AlgebraicVariable.new()
	new.variable_name = variable_name
	return new


func pretty_string() -> String:
	return variable_name
