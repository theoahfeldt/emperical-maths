class_name AlgebraicInteger
extends AlgebraicExpression


var value: int


func _to_string() -> String:
	return str(value)


static func create(
		p_value: int, p_color: Color = default_color) -> AlgebraicInteger:
	var new = AlgebraicInteger.new()
	new.value = p_value
	new.color = p_color
	return new


static func zero() -> AlgebraicInteger:
	return create(0)


func copy() -> AlgebraicInteger:
	return AlgebraicInteger.create(value, color)


func subexpressions() -> Array[AlgebraicExpression]:
	return []


func to_graphical() -> GraphicalInteger:
	return GraphicalInteger.create(value)


func mark() -> void:
	color = _sub_colors[0]


func identical_to(other: ManipulableExpression) -> bool:
	if other is AlgebraicInteger:
		return value == other.value
	return false


func pattern_match(expression: ManipulableExpression) -> PatternMatchResult:
	if identical_to(expression):
		return PatternMatchSuccess.create({})
	else:
		return PatternMatchFailure.new()


func substitute(
		_substitution: Dictionary, _replace_unspecified_variables: bool = false
		) -> AlgebraicInteger:
	return copy()


func is_zero() -> bool:
	return value == 0
