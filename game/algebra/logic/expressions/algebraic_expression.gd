class_name AlgebraicExpression
extends Node
# Abstract class


const default_color := Color.AQUA
const marked_color := Color.WHITE

@warning_ignore("unused_private_class_variable")
var _sub_colors: Array[Color] = [
	Color.from_hsv(0.1, 0.3, 1.0),
	Color.from_hsv(0.4, 0.4, 1.0),
]
var color: Color


func identical_to(_other: AlgebraicExpression) -> bool:
	push_error("Function not implemented")
	return false


func copy() -> AlgebraicExpression:
	push_error("Function not implemented")
	return AlgebraicExpression.new()


func subexpressions() -> Array[AlgebraicExpression]:
	push_error("Function not implemented")
	return []


func num_subexpressions() -> int:
	return subexpressions().size()


func replace_subexpression(_new: AlgebraicExpression, _index: int) -> void:
	push_error("Function not implemented")


func pretty_string() -> String:
	push_error("Function not implemented")
	return ""


func set_color(p_color: Color) -> void:
	color = p_color


func mark() -> void:
	set_color(marked_color)
