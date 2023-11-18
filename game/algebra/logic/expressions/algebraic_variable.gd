class_name AlgebraicVariable
extends AlgebraicExpression


@export var variable_name: String


static func create(name: String) -> AlgebraicVariable:
	var variable = AlgebraicVariable.new()
	variable.variable_name = name
	return variable


func copy() -> AlgebraicExpression:
	var new = AlgebraicVariable.new()
	new.variable_name = variable_name
	return new


func pretty_string() -> String:
	return variable_name
