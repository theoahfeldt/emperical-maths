class_name AlgebraicEquality
extends ManipulableExpression


var left_expression: AlgebraicExpression
var right_expression: AlgebraicExpression


func _to_string() -> String:
	return "%s=%s" % [left_expression, right_expression]


static func from_string(string: String) -> AlgebraicEquality:
	return AlgebraicParser.parse_equality(string)


static func create(
		left: AlgebraicExpression,
		right: AlgebraicExpression,
		p_color: Color = default_color,
		) -> AlgebraicEquality:
	var new = AlgebraicEquality.new()
	new.left_expression = left
	new.right_expression = right
	new.color = p_color
	return new


func copy() -> AlgebraicEquality:
	return AlgebraicEquality.create(
			left_expression.copy(), right_expression.copy())


func subexpressions() -> Array[AlgebraicExpression]:
	return [left_expression, right_expression]


func replace_subexpression(new: AlgebraicExpression, index: int) -> void:
	match index:
		0:
			left_expression = new
		1:
			right_expression = new
		var n:
			push_error("Invalid index: ", n)


func to_graphical() -> GraphicalEquality:
	return GraphicalEquality.create(
			left_expression.to_graphical(), right_expression.to_graphical())


func identical_to(other: ManipulableExpression) -> bool:
	if other is AlgebraicEquality:
		return (left_expression.identical_to(other.left_expression)
				and right_expression.identical_to(other.right_expression))
	return false


func pattern_match(expression: ManipulableExpression) -> PatternMatchResult:
	if expression is AlgebraicEquality:
		var left_match := left_expression.pattern_match(
				expression.left_expression)
		var right_match := right_expression.pattern_match(
				expression.right_expression)
		return PatternMatchResult.merge(left_match, right_match)
	else:
		return PatternMatchFailure.new()


func substitute(substitution: Dictionary) -> AlgebraicEquality:
	var instance_left := left_expression.substitute(substitution)
	var instance_right := right_expression.substitute(substitution)
	return AlgebraicEquality.create(instance_left, instance_right)


func set_color(p_color: Color) -> void:
	color = p_color
	left_expression.set_color(p_color)
	right_expression.set_color(p_color)


func mark() -> void:
	color = marked_color
	left_expression.set_color(_sub_colors[0])
	right_expression.set_color(_sub_colors[1])
