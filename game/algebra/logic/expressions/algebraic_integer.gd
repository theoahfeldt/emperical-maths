class_name AlgebraicInteger
extends AlgebraicExpression


var value: int


static func create(
		p_value: int, p_color: Color = default_color) -> AlgebraicInteger:
	var new = AlgebraicInteger.new()
	new.value = p_value
	new.color = p_color
	return new


static func zero() -> AlgebraicInteger:
	return create(0)


func identical_to(other: AlgebraicExpression) -> bool:
	if other is AlgebraicInteger:
		return value == other.value
	return false


func copy() -> AlgebraicInteger:
	return AlgebraicInteger.create(value, color)


func subexpressions() -> Array[AlgebraicExpression]:
	return []


func pretty_string() -> String:
	return str(value)


func to_graphical() -> GraphicalInteger:
	return GraphicalInteger.create(value)


func mark() -> void:
	color = _sub_colors[0]


func is_zero() -> bool:
	return value == 0
