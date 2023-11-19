extends Node
class_name AlgebraicExpression


var is_selected := false


func identical_to(_other: AlgebraicExpression) -> bool:
	push_error("Method not implemented.")
	return false


func copy() -> AlgebraicExpression:
	push_error("Method not implemented.")
	return AlgebraicExpression.new()


func pretty_string() -> String:
	push_error("Method not implemented.")
	return ""
