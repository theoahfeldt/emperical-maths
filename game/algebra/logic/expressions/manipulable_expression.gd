class_name ManipulableExpression
# An equality or expression that can be manipulated according to rules.


const default_color := Color.AQUA
const marked_color := Color.WHITE

@warning_ignore("unused_private_class_variable")
var _sub_colors: Array[Color] = [
	Color.from_hsv(0.1, 0.3, 1.0),
	Color.from_hsv(0.4, 0.4, 1.0),
]
var color: Color


static func from_string(_string: String) -> ManipulableExpression:
	push_error("Function not implemented")
	return ManipulableExpression.new()


func copy() -> ManipulableExpression:
	push_error("Function not implemented")
	return ManipulableExpression.new()


func subexpressions() -> Array[AlgebraicExpression]:
	push_error("Function not implemented")
	return []


func replace_subexpression(_new: AlgebraicExpression, _index: int) -> void:
	push_error("Function not implemented")


func to_graphical() -> GraphicalExpression:
	push_error("Function not implemented")
	return GraphicalExpression.new()


func identical_to(_other: ManipulableExpression) -> bool:
	push_error("Function not implemented")
	return false


func pattern_match(_expression: ManipulableExpression) -> PatternMatchResult:
	push_error("Function not implemented")
	return PatternMatchFailure.new()


func substitute(_substitution: Dictionary) -> ManipulableExpression:
	push_error("Function not implemented")
	return ManipulableExpression.new()


func set_color(p_color: Color) -> void:
	color = p_color


func mark() -> void:
	set_color(marked_color)


func num_subexpressions() -> int:
	return subexpressions().size()
