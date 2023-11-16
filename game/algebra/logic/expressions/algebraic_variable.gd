class_name AlgebraicVariable
extends AlgebraicExpression


@export var variable_name: String


static func create(name: String) -> AlgebraicVariable:
	var variable = AlgebraicVariable.new()
	variable.variable_name = name
	return variable


func _to_string() -> String:
	return variable_name
